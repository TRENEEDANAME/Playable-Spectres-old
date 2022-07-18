class X2_Ability_PASpectre extends X2Ability
	config(GameData_SoldierSkills);

var localized string WillLostFriendlyName, WillLossString;
var localized string ShadowbindUnconsciousFriendlyName;

var config int HORROR_ACTIONPOINTCOST;
var config int HORROR_COOLDOWN_LOCAL;
var config int HORROR_COOLDOWN_GLOBAL;
var config int HORROR_TOHIT_BASECHANCE;
var config int HORROR_WILL_DECREASE;

var name ShadowboundLinkName;

static function array<X2DataTemplate> CreateTemplates()
{
	local array<X2DataTemplate> Templates;

	Templates.AddItem(CreatePAHorror());

	return Templates;
}

static function X2AbilityTemplate CreatePAHorror()
{
	local X2AbilityTemplate Template;
	local X2AbilityCost_ActionPoints ActionPointCost;
	local X2AbilityCooldown_LocalAndGlobal Cooldown;
	local X2AbilityToHitCalc_RollStat RollStat;
	local X2Condition_UnitProperty UnitPropertyCondition;
	local X2Condition_UnitImmunities UnitImmunityCondition;
	local X2Effect_ApplyWeaponDamage HorrorDamageEffect;
	local X2Effect_PerkAttachForFX WillLossEffect;
	local X2Effect_LifeSteal LifeStealEffect;
	local array<name> SkipExclusions;

	`CREATE_X2ABILITY_TEMPLATE(Template, 'PAHorror');

	Template.AbilitySourceName = 'eAbilitySource_Psionic';
	Template.IconImage = "img:///UILibrary_XPACK_Common.PerkIcons.UIPerk_horror";
	Template.Hostility = eHostility_Offensive;

	ActionPointCost = new class'X2AbilityCost_ActionPoints';
	ActionPointCost.iNumPoints = default.HORROR_ACTIONPOINTCOST;
	ActionPointCost.bConsumeAllPoints = true;
	Template.AbilityCosts.AddItem(ActionPointCost);

	Cooldown = new class'X2AbilityCooldown_LocalAndGlobal';
	Cooldown.iNumTurns = default.HORROR_COOLDOWN_LOCAL;
	Cooldown.NumGlobalTurns = default.HORROR_COOLDOWN_GLOBAL;
	Template.AbilityCooldown = Cooldown;

	Template.AbilityTargetStyle = default.SimpleSingleTarget;
	Template.AbilityTriggers.AddItem(default.PlayerInputTrigger);

	// This will be a stat contest
	RollStat = new class'X2AbilityToHitCalc_RollStat';
	RollStat.StatToRoll = eStat_Will;
	RollStat.BaseChance = default.HORROR_TOHIT_BASECHANCE;
	Template.AbilityToHitCalc = RollStat;

	// Shooter conditions
	Template.AbilityShooterConditions.AddItem(default.LivingShooterProperty);
	SkipExclusions.AddItem(class'X2StatusEffects'.default.BurningName);
	Template.AddShooterEffectExclusions(SkipExclusions);

	// Target conditions
	UnitPropertyCondition = new class'X2Condition_UnitProperty';
	UnitPropertyCondition.ExcludeDead = true;
	UnitPropertyCondition.ExcludeFriendlyToSource = true;
	UnitPropertyCondition.ExcludeRobotic = true;
	UnitPropertyCondition.FailOnNonUnits = true;
	UnitPropertyCondition.ExcludeAlien = false;
	Template.AbilityTargetConditions.AddItem(UnitPropertyCondition);

	Template.AbilityTargetConditions.AddItem(default.GameplayVisibilityCondition);

	UnitImmunityCondition = new class'X2Condition_UnitImmunities';
	UnitImmunityCondition.AddExcludeDamageType('Mental');
	UnitImmunityCondition.bOnlyOnCharacterTemplate = true;
	Template.AbilityTargetConditions.AddItem(UnitImmunityCondition);

	// Target Effects
	WillLossEffect = new class'X2Effect_PerkAttachForFX';
	WillLossEffect.BuildPersistentEffect(1, false, false);
	WillLossEffect.DuplicateResponse = eDupe_Allow;
	WillLossEffect.EffectName = 'HorrorWillLossEffect';
	Template.AddTargetEffect(WillLossEffect);

	HorrorDamageEffect = new class'X2Effect_ApplyWeaponDamage';
	HorrorDamageEffect.bIgnoreBaseDamage = true;
	HorrorDamageEffect.DamageTag = 'Horror';
	HorrorDamageEffect.bIgnoreArmor = true;
	Template.AddTargetEffect(HorrorDamageEffect);

	LifeStealEffect = new class'X2Effect_LifeSteal';
	Template.AddTargetEffect(LifeStealEffect);

	Template.BuildNewGameStateFn = TypicalAbility_BuildGameState;
	Template.BuildInterruptGameStateFn = TypicalAbility_BuildInterruptGameState;
	Template.BuildVisualizationFn = TypicalAbility_BuildVisualization;

	Template.bShowActivation = true;

	Template.CinescriptCameraType = "Spectre_Horror";

	Template.LostSpawnIncreasePerUse = class'X2AbilityTemplateManager'.default.StandardShotLostSpawnIncreasePerUse;

	Template.PostActivationEvents.AddItem('HorrorActivated');
//BEGIN AUTOGENERATED CODE: Template Overrides 'Horror'
	Template.bFrameEvenWhenUnitIsHidden = true;
	Template.ActionFireClass = class'XComGame.X2Action_Fire_Horror';
	Template.CustomFireAnim = 'HL_Horror_StartA';
//END AUTOGENERATED CODE: Template Overrides 'Horror'

	return Template;
}