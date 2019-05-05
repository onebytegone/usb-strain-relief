include <lib/CornerCutout.scad>

usbWidth = 12;
usbHeight = 4.5;
cableDiameter = 3.5;

boltDiameter = 3;
boltHeadDiameter = 6;
boltHeadThickness = 2.2;
boltHoleBacking = 0.4;

cableSupportLength = 5;
usbSupportLength = 0;
wallThickness = 2.2;
cornerRadius = 3;

width = cableSupportLength + boltHeadDiameter + wallThickness + usbWidth + wallThickness;
length = wallThickness + cableDiameter + wallThickness + boltHeadDiameter + usbSupportLength;
thickness = wallThickness + usbHeight + wallThickness;
$fn = 20;

// preview();
printPlate();

module preview() {
   BottomRelief();
   translate([ 0, 0, 3]) TopRelief();

   translate([ -width - 5, 0]) printPlate();
}

module printPlate() {
   translate([ 0, 1 ])
      BottomRelief();
   translate([ 0, -1, thickness])
      rotate([ 180, 0 ])
      TopRelief();
}

module TopRelief() {
   difference() {
      StrainRelief();
      translate([ -1, -1, -1 ])
         cube([ width + 2, length + 2, thickness / 2 + 1 ]);
   }
}

module BottomRelief() {
   difference() {
      StrainRelief();
      translate([ -1, -1, thickness / 2 ])
         cube([ width + 2, length + 2, thickness / 2 + 1 ]);
   }
}

module StrainRelief() {
   difference() {
      union() {
         cube([ width, wallThickness + cableDiameter + wallThickness, thickness ]);
         cube([ wallThickness + usbWidth + wallThickness, length, thickness ]);
         cube([
            wallThickness + usbWidth + wallThickness + boltHeadDiameter,
            wallThickness + cableDiameter + wallThickness + boltHeadDiameter,
            thickness - boltHeadThickness
         ]);
      }
      CornerCutout(0, thickness, cornerRadius);
      translate([
         wallThickness + usbWidth + wallThickness + boltHeadDiameter,
         wallThickness + cableDiameter + wallThickness + boltHeadDiameter
      ]) CornerCutout(2, thickness, cornerRadius);
      translate([
         wallThickness + usbWidth + wallThickness + boltHeadDiameter / 2,
         wallThickness + cableDiameter + wallThickness + boltHeadDiameter / 2,
         boltHoleBacking
      ]) cylinder(thickness + 1, boltDiameter / 2, boltDiameter / 2);
      translate([ wallThickness, wallThickness + cableDiameter / 2, wallThickness ]) cube([
         usbWidth,
         cableDiameter / 2 + wallThickness + boltHeadDiameter + usbSupportLength + 1,
         usbHeight
      ]);
      translate([ wallThickness, wallThickness + cableDiameter / 2, thickness / 2 ])
         rotate([ 0, 90 ])
         cylinder(
            width - wallThickness + 1,
            cableDiameter / 2,
            cableDiameter / 2
         );
   }
}
