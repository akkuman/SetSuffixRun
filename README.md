## SetSuffixRun

通过修改注册表`HKEY_CLASSES_ROOT`下的键值，修改指定后缀的运行命令。

例如

```
后缀名称：.jar
执行命令："E:\Applications\Scoop\apps\oraclejdk8\current\bin\javaw.exe" -jar "%1"
```