FILE(REMOVE_RECURSE
  "../../../tools/tarsgrammar/tars.tab.hpp"
  "../../../tools/tarsgrammar/tars.tab.cpp"
  "../../../tools/tarsparse/tars.tab.hpp"
  "../../../tools/tarsparse/tars.tab.cpp"
  "CMakeFiles/COPY-LEX-YACC"
  "../../../tools/tarsgrammar/tars.lex.cpp"
  "../../../tools/tarsparse/tars.lex.cpp"
  "../../../tools/tarsgrammar/tars.tab.hpp"
  "../../../tools/tarsparse/tars.tab.hpp"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/COPY-LEX-YACC.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
