# turtle_patrol — Level 1: Waypoint Patrol (ROS 1 Noetic)

turtle1 di turtlesim mengunjungi beberapa waypoint secara berurutan dan otonom,
memakai P-controller berbasis umpan balik `/turtle1/pose`.

**Level yang diselesaikan:** Level 1 (Waypoint Patrol), Level 2 (Safe Explorer).

## Luaran

### Screenshot rqt_graph

**Level 1 — Waypoint Patrol** (`patrol.launch`)

![rqt_graph Level 1](src/turtle_patrol/docs/rqt_graph_lvl1.png)

**Level 2 — Safe Explorer** (`explorer.launch`)

![rqt_graph Level 2](src/turtle_patrol/docs/rqt_graph_lvl2.png)

### Video demo

[![Video demo turtle_patrol](https://img.youtube.com/vi/osvQoGufH_A/hqdefault.jpg)](https://youtube.com/shorts/osvQoGufH_A)

**[▶ Tonton video demo di YouTube](https://youtube.com/shorts/osvQoGufH_A)**

---

## Build dan menjalankan

```bash
git clone https://github.com/zahran-rzq/Tugas_SRO_Turtlesim.git
cd Tugas_SRO_Turtlesim    # repo ini adalah catkin workspace
catkin_make
source devel/setup.bash   # atau setup.zsh
roslaunch turtle_patrol patrol.launch
```

Misi langsung mulai otomatis. Untuk memulai manual:

```bash
roslaunch turtle_patrol patrol.launch auto_start:=false
rosservice call /start_mission "loop: false"   # loop: true = patroli berulang
```

## Mengubah waypoint
Edit satu file: `src/turtle_patrol/config/waypoints.yaml` (format `[x, y]`, area turtlesim 0..11).
Tidak perlu mengubah kode.

## Node

| Node | Peran |
|---|---|
| `mission_manager` | Memuat daftar waypoint dari YAML, menyediakan service `/start_mission`, mengirim target aktif, maju ke waypoint berikutnya saat target tercapai. |
| `waypoint_controller` | P-controller: mengejar `/current_target` berdasarkan `/turtle1/pose`, publish `/turtle1/cmd_vel` dan status misi. |

## Topic

| Topic | Tipe | Publisher → Subscriber |
|---|---|---|
| `/current_target` | `turtle_patrol/Waypoint` | mission_manager → waypoint_controller (latched) |
| `/mission_status` | `turtle_patrol/MissionStatus` | waypoint_controller → mission_manager |
| `/turtle1/pose` | `turtlesim/Pose` | turtlesim → waypoint_controller |
| `/turtle1/cmd_vel` | `geometry_msgs/Twist` | waypoint_controller → turtlesim |

## Service
`/start_mission` (`turtle_patrol/StartMission`)
- request: `bool loop`
- response: `bool accepted` (false jika misi sedang berjalan)

## Custom message
- `Waypoint`: `float32 x, y`, `int32 index, total`
- `MissionStatus`: `int32 index, total`, `float32 distance`, `bool reached, finished`

## Cara kerja controller
```
distance = hypot(gx - x, gy - y)
err      = normalize(atan2(gy - y, gx - x) - theta)   # ke [-pi, pi]
angular.z = Kp_ang * err
linear.x  = Kp_lin * distance   (hanya jika |err| < 0.5 rad)
sampai    = distance < 0.1
```
Parameter `kp_lin`, `kp_ang`, `tolerance` diatur di `src/turtle_patrol/launch/patrol.launch`.


## Level 2: Safe Explorer
```bash
roslaunch turtle_patrol explorer.launch   # jangan bersamaan dengan patrol.launch
```
| Node | Peran |
|---|---|
| `wall_sensor` | Sensor virtual: jarak ke dinding (depan/kiri/kanan lewat ray casting, dan terdekat) dari `/turtle1/pose`, publish `/wall_sensor`. |
| `explorer` | Maju sambil berkelok; jika dinding dekat, berputar ke sisi lebih lapang sampai aman (hysteresis). Publish `/turtle1/cmd_vel`. |

Custom message `WallSensor`: `float32 front, left, right, nearest`, `bool near_wall`.

## Kepatuhan aturan
- Gerak hanya lewat `/turtle1/cmd_vel` (tanpa teleop/teleport).
- Closed loop dari `/turtle1/pose`, tanpa sleep sebagai dasar gerak.
- 2 node buatan sendiri berkomunikasi lewat topic.
- 1 custom service dan 2 custom message.
- Satu perintah `roslaunch`.
