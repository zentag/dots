{
  perSystem = {
    lib,
    pkgs,
    ...
  }: {
    # run `simulate` from inside an FRC project directory (wherever that
    # project's own ./gradlew lives) to build and launch the robot code in
    # simulation.
    packages = lib.optionalAttrs pkgs.stdenv.hostPlatform.isLinux {
      simulate = pkgs.buildFHSEnv {
        name = "simulate";
        # buildFHSEnv inherits the outer JAVA_HOME (system JDK 25), which
        # Gradle 8.11 can't run on, so pin it to JDK 17 explicitly.
        runScript = pkgs.writeShellScript "simulate" ''
          export JAVA_HOME=${pkgs.temurin-bin-17}
          export PATH="$JAVA_HOME/bin:$PATH"
          exec ./gradlew simulateJava
        '';
        targetPkgs = pkgs:
          with pkgs; [
            temurin-bin-17
            stdenv.cc.cc
            libGL
            libx11
            libxtst
            gtk2
          ];
      };
    };
  };
}
