{
  LaKraven Studios Standard Library [LKSL]
  Copyright (c) 2014, LaKraven Studios Ltd, All Rights Reserved

  Original Source Location: https://github.com/LaKraven/LKSL

  License:
    - You may use this library as you see fit, including use within commercial applications.
    - You may modify this library to suit your needs, without the requirement of distributing
      modified versions.
    - You may redistribute this library (in part or whole) individually, or as part of any
      other works.
    - You must NOT charge a fee for the distribution of this library (compiled or in its
      source form). It MUST be distributed freely.
    - This license and the surrounding comment block MUST remain in place on all copies and
      modified versions of this source code.
    - Modified versions of this source MUST be clearly marked, including the name of the
      person(s) and/or organization(s) responsible for the changes, and a SEPARATE "changelog"
      detailing all additions/deletions/modifications made.

  Disclaimer:
    - Your use of this source constitutes your understanding and acceptance of this
      disclaimer.
    - LaKraven Studios Ltd and its employees (including but not limited to directors,
      programmers and clerical staff) cannot be held liable for your use of this source
      code. This includes any losses and/or damages resulting from your use of this source
      code, be they physical, financial, or psychological.
    - There is no warranty or guarantee (implicit or otherwise) provided with this source
      code. It is provided on an "AS-IS" basis.

  Donations:
    - While not mandatory, contributions are always appreciated. They help keep the coffee
      flowing during the long hours invested in this and all other Open Source projects we
      produce.
    - Donations can be made via PayPal to PayPal [at] LaKraven (dot) Com
                                          ^  Garbled to prevent spam!  ^
}
unit LKSL_Settings_Storage;

{
  About this unit: (FPC/Lazarus)
    - This unit provides the components that will interface with the storage of
    the settings key/value pairs.
    - Planned are INI files, XML files and JSON files.
    - Not planned: Database storage. DRY means you don't mess with the DB
    components already available.

  Changelog (newest on top):
    24th September 2014:
      - Initial Scaffolding
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, IniFiles, LKSL_Settings_Groups, LKSL_Settings_Fields;

type

  {
    TLKSettingsStorage
      - Base class for the settings storage.
  }

  TLKSettingsStorage = class(TComponent)
  private
  protected
    FFileName: String;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property FileName: String read FFileName write FFileName;
  end;

  TLKSettingsStorageClass = class of TLKSettingsStorage;

  {
    TLKSettingsINIStorage
      - Class that implements storage on INI files
  }

  TLKSettingsINIStorage = class(TLKSettingsStorage)
  private
    FINIFile: TIniFile;
    procedure SetFileName(AValue: String);
  protected
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property FileName: String read FFileName write SetFileName;
  end;

{
  Register
    - Procedure to register component on the component bar
}

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LKSL',[TLKSettingsINIStorage]);
end;

{ TLKSettingsStorage }

constructor TLKSettingsStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FFileName:= '';
end;

destructor TLKSettingsStorage.Destroy;
begin
  inherited Destroy;
end;

{ TLKSettingsINIStorage }

procedure TLKSettingsINIStorage.SetFileName(AValue: String);
begin
  if (FFileName <> AValue) and (Assigned(FINIFile)) then
  begin
    FFileName:= AValue;
    FreeAndNil(FINIFile);
    FINIFile:= TIniFile.Create(AValue, False);
  end;
end;

constructor TLKSettingsINIStorage.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  FINIFile:= TIniFile.Create('', False);
end;

destructor TLKSettingsINIStorage.Destroy;
begin
  if Assigned(FINIFile) then
  begin
    FINIFile.Free;
  end;
  inherited Destroy;
end;

end.
