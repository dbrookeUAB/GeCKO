#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]
CharacterVector revComplement(std::vector<std::string> seqMain)
{
  
  int n = seqMain.size();
  
  std::vector<std::string> res(n);
  for (int i=0; i < n; i++)
  {
    std::string tmp = seqMain[i];
    
    int n2 = tmp.size();
    
    for(int j=0; j<n2; j++) {
      
      tmp[j]= seqMain[i][n2-(j+1)];
      
      if (tmp.compare(j, 1, "A") == 0) {           // checks for A
        tmp.replace(j,1,"T");                      // A to T
      } else if (tmp.compare(j, 1, "T") == 0){     // checks for T
        tmp.replace(j,1,"A");                      // T to A
      } else if (tmp.compare(j, 1, "G") == 0){     // checks for G
        tmp.replace(j,1,"C");                      // G to C
      } else if (tmp.compare(j, 1, "C") == 0){     // checks for C
        tmp.replace(j,1,"G");                      // C to G
      } else {
        tmp.replace(j,1,"X");
      }
    }
    
    res[i] = tmp;
  }
  return wrap(res);
}

/*** R
revComplement(c("ATGC","TGCA","GCAT","CATG","CCCC","GGGG","AAAA","TTTT"))
*/
