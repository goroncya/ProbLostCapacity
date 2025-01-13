# Author: Agnieszka Goroncy 
# 
# k-out-of-n weighted systems
# with positive integer weights wi
# in the case of the discrete component lifetimes

#########################################################################
# Function search_comp
# - searches for the indices of components which weights sum up to m
#  	
#########################################################################

require(gtools)
require(sets)

search_comp <- function(wi,k,m) {
# INPUT:
# 	wi - vector of component weights: positive, integer
#	k - parameter of the weighted k-out-of-n-system
#	m - capacity loss of the weighted k-out-of-n-system
# 	    (possible values of m: from sum(wi)-k+1 to sum(wi))
# OUTPUT: 
# list of the sets of component indices 
# (corresponding to the vector of components with nondecreasingly ordered weights) 
# which weights sum up to m
	w<- sum(wi)		# initial system capacity
	n<-length(wi)	# number of components in the system
if (m<=w-k | m>w) {
		cat("Parameter 'm' must be from",w-k+1,"to", w,"\n")
	} else { 
	if (m==w) {		# lost capacity equals to the initial system capacity
		t_le<-list(as.set(as.numeric(1:n)))
		return(t_le)
	} else {
	wi<-sort(wi[wi<=m])		
	we<-1:n
	permutacje<- permutations(n,n,we)	
	l_perm<- factorial(n)
	t_le<-list()
	for (i in 1:l_perm) {
		weights<-wi[permutacje[i,]]
		for (j in 1:n) {
			wei<-weights[1:j]
			ind<- permutacje[i,1:j]
			wei<- wi[permutacje[i,1:j]]
			sum_wi<-sum(wei)
			if (sum_wi==m & sum_wi>w-k) {
			
				t_le[i]<-list(as.set(as.numeric(ind)))
			} 
		}	# end for j
	}	# end for i
	if (	length(t_le) >0 ) {
	wh<- which(sapply(t_le, is.null))
   	if(length(wh)>0) t_le<- t_le[-wh]
	t_le_u<- unique(t_le)
	return(t_le_u)
	} else {
		cat("There are no subsets of component weights that sum up to m=",m,"\n")
		t_le_u<-list()
		return(t_le_u)
		}
	} 	#else if <check m==w>
}	#else if <check m>
} # end function
