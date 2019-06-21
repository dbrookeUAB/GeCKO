#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]

CharacterVector oligo_mod(std::vector<std::string> seq5p,
                             std::vector<std::string> seqMain,
                             std::vector<std::string> seq3p)
{
  std::vector<std::string> res(seqMain.size());
  for (int i=0; i < seqMain.size(); i++)
  {
    res[i]=seq5p[i]+seqMain[i]+seq3p[i];
  }
  return wrap(res);
}


