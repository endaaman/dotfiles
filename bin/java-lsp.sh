java \
  -agentlib:jdwp=transport=dt_socket,server=y,suspend=n,address=1044
  -Declipse.application=org.eclipse.jdt.ls.core.id1 \
  -Dosgi.bundles.defaultStartLevel=4 \
  -Declipse.product=org.eclipse.jdt.ls.core.product \
  -Dlog.level=ALL \
  -noverify \
  -Xmx1G \
  -jar ./plugins/org.eclipse.equinox.launcher_1.4.0.v20161219-1356.jar \
  -configuration ./config_linux \
  -data /path/to/data
  --add-modules=ALL-SYSTEM \
  --add-opens java.base/java.util=ALL-UNNAMED

