contigname=$1
start=$2
end=$3
file=$4
output="$5.fasta"
strand=$6

if [ "$contigname" == "" ]; then
	echo "no contigname was provided"
	exit
fi

if [ "$start" == "" ];then
	echo "no start position was provided"
	exit
fi

if [ "$end" == "" ];then
	echo "no end position was provided"
	exit
fi

if [ "$file" == "" ];then
	echo "no $file found"
	exit
fi

if [ "$output" == ".fasta" ];then
	output="output.fasta"
fi

if [ "$strand" == "" ];then
	echo "strand option default: +"
	strand="+"
fi
if [ "$strand" != "+" ];then
	strand="-"
fi

function getGene {
	awk -v contigname="$1"  -v start="$2" -v end="$3" -v strand="$5" 'BEGIN{cband=0;cposition=1;container=0}
		{
			if($0 ~ contigname){
				cband=1
				print $0" "strand"("start":"end")"
				next
			}
			if(cband==1){
				split($0, chars, "")
				for(i=1;i<=length($0);i++){
					if(cposition>=start && cposition<end){
						if(container<60){
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
			if($0~">"){
				exit
			}
		}' $4
}

case $strand in
	"+")
		getGene $contigname $start $end $file > $output
	;;
	"-")
		getGene $contigname $start $end $file "c" | awk 'BEGIN{t["A"]="T";t["T"]="A";t["G"]="C";t["C"]="G";t["a"]="t";t["t"]="a";t["g"]="c";t["c"]="g";t["N"]="N";t["n"]="n";container=0;cposition=1;seq=""}
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
					if(container<60){
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


