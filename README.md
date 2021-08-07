## Sample Qt 5.15 QML (QtQuick) CMake hello world

Sample QML application for getting started with Qt + CMake. 
This Qt QML app uses Qt >= 5.15 and CMake >= 3.16 and draws a 
QML scene with a SVG icon.

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

When running the application, this is the output:

```text
SSL version:  "OpenSSL 1.1.1f  31 Mar 2020"
SSL build:  "OpenSSL 1.1.1g  21 Apr 2020"
qml: ApplicationWindow loaded!
qml: QT runtime: 5.15.2
```

And of course the QML application itself is shown.

### Static binaries

The `CMakeLists.txt` has an option to prepare static compilation, but it 
is up to the user to prepare & compile their own custom static Qt installation. 
Static compilation is out-of-scope for this document/project as it is a big topic 
on it's own.

Regardless, the `if(STATIC)` clauses in the provided `CMakeLists.txt` and `src/CMakeLists.txt` serve as 
an example of what is roughly needed for static Qt5 QML compilation as far as CMake goes.

Note that `qt5_import_qml_plugins()` is used which is handy for static compiles, 
as it automatically scans which QML plugins you are using so you don't have to 
manually use the `Q_IMPORT_PLUGIN` macro.

```text
cmake -DSTATIC=ON -DCMAKE_PREFIX_PATH="/home/user/qt5.15/gcc_64" -Bbuild .
```

### Mac OS

There is some code regarding Mac OS in both `CMakeLists.txt` and 
`src/CMakeLists.txt`, most importantly the ability for CMake to 
directly use `macdeployqt` to create a Mac OS 'bundle' for the 
Qt application automatically (can be observed in `cmake/Deploy.cmake`).

### Windows

This CMake project ignores Windows, as if it does not exist, which is 
nice - I pretend Windows does not exist all the time :D

### Support

I will ignore your Github issues.
