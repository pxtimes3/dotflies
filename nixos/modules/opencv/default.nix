{ pkgs ? import <nixpkgs> {} }:
pkgs.mkShell {
  name = "opencv-python-gtk";
  buildInputs = with pkgs; [
    (python312.withPackages
      (ps: with ps; [
        (ps.opencv4.override {
          enableGtk3 = true;
        })
      ])
    )
  ];
}
