FILE(REMOVE_RECURSE
  "CMakeFiles/framework-tar"
  "../framework.tgz"
)

# Per-language clean rules from dependency scanning.
FOREACH(lang)
  INCLUDE(CMakeFiles/framework-tar.dir/cmake_clean_${lang}.cmake OPTIONAL)
ENDFOREACH(lang)
