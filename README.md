This project concerns the reliability weighted k-out-of-n system with component lifetimes modelled by the IID geometrically distributed random variables.
Each component has a positive integer-valued weight assigned interpreted as its total capacity. The system is in a working state if the accumulated weights 
of all working components are at least k. 
The primary focus is the capacity lost by the system upon its failure, for which we derive the probability mass function. 
This quantity has a potential that enables optimal system design. 
The project consists of two functions:
1. search_comp(wi, k, m) - searches for the indices of components of the weighted k-out-of-n system, which weights sum up to m. 
  INPUT:
  wi - vector of component weights: positive, integer;
  k - parameter of the weighted k-out-of-n-system;
  m - capacity loss of the weighted k-out-of-n-system (possible values of m: from sum(wi)-k+1 to sum(wi)).
  OUTPUT:
  list of the sets of component indices (corresponding to the vector of components with nondecreasingly ordered weights) 
  which weights sum up to m.
2. prob_lost_capacity(wi,k,m,t,q) - calculates the probability that the capacity lost by the k-out-of-n weigthed system equals to m
   at time of the system failure t: P(W_n^*=m, t=t), when the component lifetimes are IID geometrically distributed with parameter q

References: 
Goroncy A., Jasinski K., Korejwo F., Rudzate M., Lost capacity of the weighted k-out-of-n system with discrete component lifetimes, under review, 2024.

