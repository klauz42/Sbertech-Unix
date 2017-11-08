#!/bin/bash

if [[ $# -lt 1 ]]
then 
	echo "Параметр не переданы! (Следует передать права доступа в цифровом формате)"
	exit 1
elif [[ $# -gt 1 ]]
then
	echo "Должен быть единственный параметр! (Следует передать права доступа в числовом формате)"
	exit 1
fi

if !(echo "$1" | grep -E -q "^[0-7]{3}$")
then
	echo "Передан неверный параметр!"
	exit 1
fi 
echo
echo "Приветствую! Меня зовут ИЗ-7. Я призван проверить названия файла и, в случае отсутствия, создать его с указанными в параметре (в числовом формате) правами"
echo

fn= #очистим
check=0
length=0

while [[ $check -ne 42  ]]
do
	if [ $check -eq 0 ]
	then
		echo -n "Введите название файла: "
		check=1
		read fn 
		
	elif [[ $length -gt 255 ]]
	then
		echo "Слишком длинное название. Будьте добры повторить: "
		check=2
		read fn 	
	else
		check=42
	fi	
	length=${#fn}
done

echo
fileExists=

fileExists=$(find ~ -maxdepth 2 -type f -name "$fn"| tee /dev/tty)

if test -z $fileExists
then
	echo -n "Файла не существует. Создаю его в  домашней директории. Введите текст (Ctrl-D для прекращения ввода): "
	cat > ~/"$fn"
	chmod "$1" ~/"$fn"
	echo
	echo "Успех!" 
else
	echo
	echo "Перечислены соответствующие файлы"		
fi	 
