#deploy tarsnotify-tar
EXECUTE_PROCESS(
WORKING_DIRECTORY /root/Tars/cpp/build/framework/deploy/
COMMAND tar czfv /root/Tars/cpp/build/tarsnotify.tgz tarsnotify
)
