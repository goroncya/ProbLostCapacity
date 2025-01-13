# Author: Agnieszka Goroncy 
# 
# k-out-of-n weighted systems
# with positive integer weights wi
# in the case of the discrete component lifetimes

#############################################################################
# Function that calculates 
# probability that the capacity lost by the k-out-of-n weigthed system
# equals to m at time of the system failure t
# P(W_n^*=m, t=t)
# when the component lifetimes are IID geometrically distributed with parameter q
# 
# REMARK: Requires function search_comp()
#   	
#########################################################################

require(gtools)
require(sets)

prob_lost_capacity <- function(wi,k,m,t,q) {
# INPUT:
# 	wi - vector of component weights: positive, integer
#	k - parameter of the weighted k-out-of-n-system
#	m - capacity loss of the weighted k-out-of-n-system
# 	    (possible values of m: from sum(wi)-k+1 to sum(wi))
#	t - time of the system failure, t=1,2,3,...	
#	q - parameter of the geometric distribution of each component's lifetime
# OUTPUT: 
# probability that the capacity lost by the k-out-of-n weigthed system
# equals to m at time of the system failure t: P(W_n^*=m, t=t)
	# P(X=t) - probability mass function of Geo(q), t=1,2,...
	p<- function(q,t) q*(1-q)^(t-1)
	# F_bar(t)=P(X>t)=1-F(X<=t) - survival function of Geo(q), t=0,1,2,...
	F_bar<- function(q,t) (1-q)^t
	# F(t-)=P(X<t), t=1,2,... 
	F_<- function(q,t) 1-(1-q)^(t-1)	
	w<- sum(wi)
	n<-length(wi)
	t_le_u<- search_comp(wi,k,m) 
if (length(t_le_u)>0) {
	nl<- length(t_le_u)
	prob<-0
	for (i in 1:nl) {
	if (length(unlist(t_le_u[i]))>0){
		comps<- unlist(t_le_u[i])
		n_comps<-length(comps)
		perm<- permutations(n_comps,n_comps,comps)
		if (n_comps==1) {
			prob<- prob + p(q,t)^(n_comps)*F_bar(q,t)^(n-n_comps)
		} else {
		for (j in 1:n_comps) {	# podzbiory komponentów
			sets<- combn(comps, j)
			l_el<-length(sets[1,])	# number of subsets composed of j elements
			l_el
			for (r in 1:l_el) {	
				inde<- sets[,r]	
				wagi<-wi[inde]
				s1<- sum(wagi)
				if (s1<=w-k & j!=n_comps) {
					prob<- prob + F_(q,t)^(j)*p(q,t)^(n_comps-j)*F_bar(q,t)^(n-n_comps)
				} else {
				if (j==n_comps) {
					prob<- prob + p(q,t)^n_comps*F_bar(q,t)^(n-n_comps)
					} else { 
					if (s1<=w-m & j!=n_comps) {	
						}	
						}
				} # end if
				} #end for r 	
		}	# end for j
		} # end else if n_comps==1
	} # end if
	} # end for i
return(prob)
} else return(0)
} # end function prob_lost_capacity	