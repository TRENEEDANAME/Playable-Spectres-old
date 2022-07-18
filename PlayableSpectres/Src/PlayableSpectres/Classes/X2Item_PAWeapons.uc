class X2Item_PAWeapons extends X2Item
	config(PlayableSpectres);

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> ModWeapons;
	`log ("davea debug weapon-create-templates enter");
	ModWeapons.AddItem(CreateTemplate_PA_SpectreGun());

	`log ("davea debug weapon-create-templates done");
	
	return ModWeapons;
}

static function X2DataTemplate CreateTemplate_PA_SpectreGun()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'PA_SpectreGun');

	Template.WeaponPanelImage = "_MagneticRifle";
	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'PA_SpectreGunCat';
	Template.strImage = "img:///UILibrary_Common.AlienWeapons.MutonRifle";
	Template.EquipSound = "Magnetic_Weapon_Equip";
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer);

	Template.RangeAccuracy = class'X2Item_DefaultWeapons'.default.MEDIUM_MAGNETIC_RANGE;
	Template.BaseDamage = class'X2Item_DefaultWeapons'.default.MUTON_WPN_BASEDAMAGE;
	Template.Aim = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_AIM;
	Template.CritChance = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_CRITCHANCE;
	Template.iClipSize = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ICLIPSIZE;
	Template.iSoundRange = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_ISOUNDRANGE;
	Template.iEnvironmentDamage = class'X2Item_DefaultWeapons'.default.ASSAULTRIFLE_MAGNETIC_IENVIRONMENTDAMAGE;
	Template.iIdealRange = class'X2Item_DefaultWeapons'.default.MUTON_IDEALRANGE;

	Template.NumUpgradeSlots = 2;

	Template.DamageTypeTemplateName = 'Heavy';

	Template.InventorySlot = eInvSlot_PrimaryWeapon;
	Template.Abilities.AddItem('StandardShot');
	Template.Abilities.AddItem('Overwatch');
	Template.Abilities.AddItem('OverwatchShot');
	Template.Abilities.AddItem('Reload');
	Template.Abilities.AddItem('HotLoadAmmo');
	// added as class levels up: Template.Abilities.AddItem('Suppression');
	// added as class levels up: Template.Abilities.AddItem('Execute');
	Template.GameArchetype = "WP_SpectreRifle.WP_SpectreRifle";
	Template.iPhysicsImpulse = 5;

	Template.CanBeBuilt = false;
	Template.TradingPostValue = 30;
	Template.bInfiniteItem = true;

	Template.DamageTypeTemplateName = 'Projectile_Conventional';

	return Template;
}

static function X2DataTemplate CreateTemplate_SpecPsiAmp()
{
	local X2WeaponTemplate Template;

	`CREATE_X2TEMPLATE(class'X2WeaponTemplate', Template, 'SpecPsiAmp');

	Template.ItemCat = 'weapon';
	Template.WeaponCat = 'PA_SpecterPsiCat';
	Template.WeaponTech = 'alien';
	Template.strImage = "img:///UILibrary_StrategyImages.X2InventoryIcons.Inv_Psi_Amp";
	Template.InventorySlot = eInvSlot_SecondaryWeapon;
	Template.StowedLocation = eSlot_RightBack;
	// This all the resources; sounds, animations, models, physics, the works.
	Template.RemoveTemplateAvailablility(Template.BITFIELD_GAMEAREA_Multiplayer); //invalidates multiplayer availability

	Template.CanBeBuilt = false;

	Template.DamageTypeTemplateName = 'Psi';

	Template.Abilities.AddItem('Horror');
	
	Template.ExtraDamage = class'X2Item_DefaultWeapons'.default.PSIAMPT3_ABILITYDAMAGE;

	Template.StartingItem = true;
	Template.CanBeBuilt = false;

	Template.bInfiniteItem = true;

	return Template;
}