#include <Rcpp.h>
using namespace Rcpp;

// [[Rcpp::export]]

CharacterVector oligo_mod(std::string seq5p,
                          std::string seqMain,
                          std::string seq3p)
{
  
  return wrap(seq5p + seqMain + seq3p);
}


// [[Rcpp::export]]
CharacterVector Voligo_mod(std::vector<std::string> seqMain,
                           std::string seq5p,
                           std::string seq3p
                           )
{
  std::vector<std::string> res(seqMain.size());
  for (int i=0; i < seqMain.size(); i++)
  {
    res[i]=seq5p+seqMain[i]+seq3p;
  }
  return wrap(res);
}


