#deploy framework-tar
EXECUTE_PROCESS(
WORKING_DIRECTORY /root/Tars/cpp/build/framework/deploy/
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tars_install.sh .
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tarsnode .
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tarsregistry .
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tarsAdminRegistry .
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tarspatch .
COMMAND cp -rf /root/Tars/cpp/framework/deploy/tarsconfig .
COMMAND tar czfv /root/Tars/cpp/build/framework.tgz tars_install.sh;tarsnode_install.sh tarsnode tarsregistry tarsAdminRegistry tarspatch tarsconfig
)
