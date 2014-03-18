#!/bin/bash
#ip switch for Linux
#author: mlsx
#blog: http://blog.wgzhao.com
#Date: 2008.5.27

#directory save ip profile
dir="/etc/.inet"
function usage
{
  echo "Usage: $0 args \
	args means:
	  -a, --add : add an interface profile
	  -p, --apply: apply this profile 
	  -d, --del <name> : delete an interface profile
	  -l, --list [name] : list all profile,then specify a name"
  exit 67
}

function add_interface
{
  while true
  do
	echo -n "Please a profile name(DO NOT include space)[new]:"
	read name
	[ "$name" == "" ] && name="new"
	if [ -f "$dir/$name" ];then
	  echo "Sorry,the profile name is exists!"
	else
	  break;
	fi
  done
  echo 
  echo  -n "Please your interface[eth0]:"
  read inet
  if [ "$inet" == "" ];then inet="eth0"; fi
  echo 
  while true
  do
	echo "Please Choice:"
	echo " 1) dhcp "
	echo " 2) static ip"
	echo -n "choose your number[1]:"
	read ch
	[ "$ch" == "" ] && ch="1"

	if [ "$ch" != "1" ] && [ "$ch" != "2" ];then
	  echo "incorrect choice"
	else
	  break
	fi
  done
  if [ "$ch" == "2" ];then
	echo -n "IP Address: "
	read ip
	echo -n "netmask: "
	read netmask
	echo -n "gateway: "
	read gateway
	exec 6>&1
	exec >"$dir/$name"
	echo "auto $inet"
	echo "iface $inet inet static"
	echo -e "\t address $ip \n
			 \t netmask $netmask \n
			 \t gateway $gateway" 
  else
	echo "auto $inet " >"$dir/$name"
	echo "iface $inet inet dhcp" >>"$dir/$name"
  fi
  exit 0
}

function del_interface ()
{
  if [ -f "$dir/$1" ];then
    rm -f "$dir/$1"
  else
	echo "No such profile name"
	exit 68
  fi
  exit 0
}

function list_interface()
{
  if [ $# -gt 0 ];then
	while [ $# -ne 0 ]
	do
	if [ -f $dir/$1 ];then  
	  echo "detail profile of $1:"
	  cat $dir/$1
	else
	  echo "$1 : no such profile "
	fi
	  shift
	done
  else
    ls -w 1 $dir
  fi
  exit 0
}

function apply_interface
{
  if [ ! -f "$dir/$1" ]; then
	echo "profile $1 not exists!"
	exit 69
  fi
  inet=`head -n 1 "$dir/$1" | awk '{print $2}'`
  #for debian distros
  grep -i 'ubuntu' /proc/version
  ret1=$?
  grep -i 'debian' /proc/version
  ret2=$?
  if [ $ret1 -eq 0 ] || [ $ret2 -eq 0 ];then
	#first,offline interface
	ifdown $inet 2>/dev/null
	ifup -i "$dir/$1" $inet
  else
	#LSB debian
	#is dhcp?
	grep 'inet dhcp' "$dir/$1"
	if [ $? -eq 0 ];then
	  ifconfig $inet down
	  killall dhclient
	  dhclient $inet
	else
	  #static ip
	  ipaddress=`sed -n '/address/p' xinfang  |cut -d' ' -f2`
	  netmask=`sed -n '/netmask/p' xinfang  |cut -d' ' -f2`
	  gateway=`sed -n '/gateway/p' xinfang  |cut -d' ' -f2`
	  ifconfig $inet down
	  ifconfig $inet $ipaddress netmask $netmask up
	  route add default gw $gateway dev $inet
	fi
  fi
  #SuSe
  exit 0
}

if [ $UID -ne 0 ];then
echo "this utility required root privilege"
exit 65
fi
[ -d $dir ] || mkdir $dir

if [ ! -f $file ];then
  echo "$file not exists! exit"; 
  exit 66
fi

[ $# -eq 0 ] && usage

TEMP=`getopt -o ap:d:l:: --long add,apply,del:,list:: -n $0 -- "$@"`

if [ $? != 0 ] ; then usage ; exit 1 ; fi

# Note the quotes around `$TEMP': they are essential!
eval set -- "$TEMP"

while true ; do
	case "$1" in
		-a|--add) add_interface; break;;
		-p|--apply) shift;apply_interface  $1; break;;
		-d|--del) shift; del_interface $1; break;;
		-l|--list)  shift 3; list_interface $*; break;;	  
		*) usage ;;
	esac
done
