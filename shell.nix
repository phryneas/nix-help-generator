with import <nixpkgs> {};
 
stdenv.mkDerivation {
  name="nix-grammar";
  /* dependencies */
  buildInputs = [ jdk8 antlr4 ];
  # hook
  shellHook = ''
    export CLASSPATH="${antlr4}/share/java/antlr-4.7.1-complete.jar:$CLASSPATH"
    echo "antlr nix.g4; javac *.java; grun nix file -tree test.nix"
  '';
 }