## Sample Qt 5.15 QML CMake hello world

Sample QML application (+extras):

- C++ 17, Qt5.15, CMake, CCache
- QtWidgets & QtQuick
- Main and About window
- Embedded Qt resource (QRC) 
- static utils class
- Config directory + config file

See also:

- Qt5 QtWidgets template: [qt5-widgets-cmake-hello-world](https://github.com/kroketio/qt5-widgets-cmake-hello-world)
- Qt5 QML template (this): [qt5-qml-cmake-hello-world](https://github.com/kroketio/qt5-qml-cmake-hello-world)
- Qt5 Widgets + QML template: [qt5-widgets-qml-cmake-hello-world](https://github.com/kroketio/qt5-widgets-qml-cmake-hello-world)

### Installation (Linux / Mac OS)

To build, run:

```text
cmake -Bbuild .
make -Cbuild -j4
```

And if you have Qt installed in a custom directory, use this CMake command instead:

```text
cmake -DCMAKE_PREFIX_PATH="/home/user/qt5.15/gcc_64" -Bbuild .
```

Which will produce the executable `build/bin/qml_hello`, which is dynamically linked.
