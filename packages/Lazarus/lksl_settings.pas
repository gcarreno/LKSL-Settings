{ This file was automatically created by Lazarus. Do not edit!
  This source is only used to compile and install the package.
 }

unit LKSL_Settings;

interface

uses
  LKSL_Settings_Storage, LKSL_Settings_Manager, LKSL_Settings_Groups, 
  LKSL_Settings_Fields, LazarusPackageIntf;

implementation

procedure Register;
begin
  RegisterUnit('LKSL_Settings_Storage', @LKSL_Settings_Storage.Register);
  RegisterUnit('LKSL_Settings_Manager', @LKSL_Settings_Manager.Register);
  RegisterUnit('LKSL_Settings_Groups', @LKSL_Settings_Groups.Register);
end;

initialization
  RegisterPackage('LKSL_Settings', @Register);
end.
