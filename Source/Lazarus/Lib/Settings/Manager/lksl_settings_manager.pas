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
unit LKSL_Settings_Manager;

{
  About this unit: (FPC/Lazarus)
    - This unit provides the components that manage in memory field/value pairs.

  Changelog (newest on top):
    24th September 2014:
      - Initial Scaffolding
}

{$mode objfpc}{$H+}

interface

uses
  Classes, SysUtils, LKSL_Settings_Storage, LKSL_Settings_Groups,
  LKSL_Settings_Fields;

type
  {
    TLKSettingsManager
      - Base class for the settings management.
  }

  TLKSettingsManager = class(TComponent)
  private
  protected
    FSettingsStorage: TLKSettingsStorage;
    FSettingsGroups: TLKSettingsGroups;
  public
    constructor Create(AOwner: TComponent); override;
    destructor Destroy; override;
  published
    property Storage: TLKSettingsStorage read FSettingsStorage write FSettingsStorage;
    // Need to assess which of these will enable array syntax:
    //property Groups[Index: Integer]: TLKSettingsGroup read GetSettingsGroup;
    property Groups: TLKSettingsGroups read FSettingsGroups;
  end;

  TLKSettingsManagerClass = class of TLKSettingsManager;

{
  Register
    - Procedure to register component on the component bar
}

procedure Register;

implementation

procedure Register;
begin
  RegisterComponents('LKSL',[TLKSettingsManager]);
end;

{ TLKSettingsManager }

constructor TLKSettingsManager.Create(AOwner: TComponent);
begin
  inherited Create(AOwner);
  //FSettingsStorage:= TLKSettingsStorage.Create(Self);
  //FSettingsStorage.SetSubComponent(True);
  FSettingsGroups:= TLKSettingsGroups.Create(Self);
  FSettingsGroups.SetSubComponent(True);
end;

destructor TLKSettingsManager.Destroy;
begin
  if Assigned(FSettingsStorage) then
  begin
    FSettingsStorage.Free;
  end;
  if Assigned(FSettingsGroups) then
  begin
    FSettingsGroups.Free;
  end;
  inherited Destroy;
end;

end.
