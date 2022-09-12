#!/bin/bash
iniDir=$(pwd)
mkdir "${iniDir}"/trush
if ! tar -xf "${iniDir}"/nvim-linux64.tar.gz; then
	echo -e "\033[41;30m        系统没有tar         \033[0m"
else
	mv "${iniDir}"/nvim-linux64.tar.gz "${iniDir}"/trush
fi

cp "${iniDir}"/int42.sh "${iniDir}"/nvim-linux64/bin/
cp "${iniDir}"/open.sh "${iniDir}"/nvim-linux64/bin/
cp -R "${iniDir}"/share/nvim/* "${iniDir}"/nvim-linux64/share/nvim/
cp -R "${iniDir}"/runtime/lua/* "${iniDir}"/nvim-linux64/share/nvim/runtime/lua/
mkdir -p "${iniDir}"/nvim-linux64/share/nvim/abc/cmp/snippets/{lua,vscode}

mv "${iniDir}"/initial.sh "${iniDir}"/trush
mv "${iniDir}"/open.sh "${iniDir}"/trush
mv "${iniDir}"/int42.sh "${iniDir}"/trush
mv "${iniDir}"/runtime "${iniDir}"/trush
mv "${iniDir}"/share "${iniDir}"/trush

echo -e "\033[34m安装已经完成\n进入nvim-linux64/bin目录执行 source int42.sh\n执行完后当前shell环境将增加alias n，该alias会打开neovim即在终端输入n即可\n第一次进入neovim会下载插件，请确保访问GitHub的网络环境\n插件的下载需要git命令，请确保有git命令，除此之外确保有nodejs\n第二次进入neovim请输入命令:PackSync 和 :TSupdate\n输入命令:checkhealth检查neovim的健康状态\n可以将trush目录删掉\033[0m"
