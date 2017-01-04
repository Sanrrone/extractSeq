if [[ "$@" =~ "--debug" ]]; then
	set -ex
else
	set -e
fi

if [[ "$@" =~ "-h" ]]; then
	echo "* Usage: bash extractSeq.bash contigname start[int] end[int] strand[+/-] output file.fasta"
	exit
fi

contigname=$1
start=$2
end=$3
strand="$4"
output="$5.fasta"
myfile=$6


if [ "$contigname" == "" ]; then
	echo "* no contigname was provided"
	exit
fi

if [ "$start" == "" ];then
	echo "* no start position was provided"
	exit
fi

if [ "$end" == "" ];then
	echo "* no end position was provided"
	exit
fi

if [ "$strand" == "" ];then
	echo "* strand option default: +"
	strand="+"
fi

if [ "$output" == ".fasta" ];then
	output="output.fasta"
fi

if [ "$myfile" == "" ];then
	echo "* no $myfile found"
	exit
fi

function getGene {
	myfile=`echo "$4" |awk -F"/" '{print $NF}'`
	awk -v contigname="$1"  -v start="$2" -v end="$3" -v myfile="$myfile" -v strand="$5" 'BEGIN{cband=0;cposition=1;container=0}
		{
			if($0 ~ contigname){
				cband=1
				print $0"_"myfile"_"strand"("start":"end")"
				next
			}
			if(cband==1){
				split($0, chars, "")
				for(i=1;i<=length($0);i++){
					if(cposition>=start && cposition<end){
						if(container<70){
							printf "%c",chars[i]
							container++	
						}else{
							printf "%c\n",chars[i]
							container=0
						}
					}
					if(cposition==end){
						printf "%c\n",chars[i]
						exit
					}
					cposition+=1
				}
			}
			if($0~">" && cband==1){
				printf "\n"
				exit
			}
		}' $4
}

case $strand in
	"+")
		getGene $contigname $start $end $myfile > $output
	;;
	"-")
		getGene $contigname $start $end $myfile "c" | awk 'BEGIN{t["A"]="T";t["T"]="A";t["G"]="C";t["C"]="G";
		t["a"]="t";t["t"]="a";t["g"]="c";t["c"]="g";t["N"]="N";t["n"]="n";t[""]
		t["R"]="Y";t["r"]="y";t["Y"]="R";t["y"]="r";t["K"]="M";t["M"]="K";t["k"]="m";t["m"]="k";
		t["S"]="S";t["s"]="s";t["W"]="W";t["w"]="w";t["B"]="V";t["V"]="B";t["b"]="v";t["v"]="b";
		t["D"]="H";t["H"]="D";t["d"]="h";t["h"]="d";t["d"]="h"
		;container=0;cposition=1;seq=""}
			{
				if(NR>1){
					seq=seq""$0
				}else{
					print $0
				}
			}
			END{				
				split(seq, chars, "")
				for(i=length(seq);i>=1;i--){
					if(container<70){
						printf "%c",t[chars[i]]
						container++	
					}else{
						printf "%c\n",t[chars[i]]
						container=0
					}

					if(cposition==end){
						printf "%c\n",t[chars[i]]
						exit
					}
					cposition+=1
				}
			}' > $output
	;;
	*)
		echo "invalid strand"
		exit
	;;
esac


