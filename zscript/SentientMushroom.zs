/*
Name: Sentient Mushroom
Difficulty: Easy
Connections: None
Summon: SentientMushroom, SMRandomSpawner
Melee: No
Distance: Projectile
Type: Magic, Fungi
Brightmaps: No
Added States: No
ACS: No

Submitted: Gothic
Code: Gothic
GLDefs: Gothic
Sounds: Raven Software (Hexen), Monolith Productions (Blood)
Sprites: Raven Software (ShadowCaster, Hexen)
Sprite Edit: Gothic


What seems to be a regular decoration, is actually a dangerous creature that tosses
poisonous gas around it to keep intruders out of its territory. If you hear a squeal,
you better keep your distance.

Includes a random spawner for the surprise factor on your maps.
*/

class SentientMushroom : Actor
{
    Default
    {
        Radius 20;
        Height 46;
        Health 200;
        DamageFactor "Poison", 0;
        DamageFactor "PoisonCloud", 0;
        MaxTargetRange 4;
        Monster;
        +DONTTHRUST;
        +NOTARGET;
        +NOBLOOD;
        +CANTSEEK;
        +NOTAUTOAIMED;
        ActiveSound "Mushroom/Idle";
        DeathSound "Mushroom/Die";
    }

    States
	{
	Spawn:
		MSHR A 1 A_Look;
		Loop;
	See:
		MSHR A 6 A_Chase(null,"Missile",CHF_DONTMOVE);
		Loop;
	Missile:
		TNT1 A 0 A_JumpIfInventory("CloudNotGoneYet",1,"See");
		TNT1 A 0 A_SetCantSeek(false);
		MSHR B 4 A_SetNotAutoAimed(false);
		MSHR CD 4;
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,0,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,45,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,90,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,135,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,180,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,225,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,270,0,0,0);
		TNT1 A 0 A_SpawnItemEx("ShroomCloud",0,0,40,16,0,0,315,0,0,0);
		MSHR E 8 A_StartSound("Mushroom/Attack",0,1.0);
		MSHR DF 4;
		TNT1 A 0 A_SetCantSeek(true);
		MSHR B 4 A_SetNotAutoAimed(true);
		MSHR A 4 A_GiveInventory("CloudNotGoneYet");
		Goto See;
	Death:
		MSHR G 4 A_ScreamandUnblock;
		MSHR HIJ 4;
		MSHR K -1;
		Stop;
	Burn:
		MSHR H 3;
		MSHR L 4 Bright A_StartSound("Mushroom/Fire",0,1.0);
		MSHR M 4 Bright A_Fall;
		MSHR NOP 5 Bright;
		MSHR UQR 4;
		MSHR S -1;
		Stop;
	Ice:
		MSHR T 5 A_FreezeDeath;
		MSHR T 1 A_FreezeDeathChunks;
		Wait;
	}

    action void A_SetCantSeek(bool value)
    {
        invoker.bCANTSEEK = value;
    }
    action void A_SetNotAutoAimed(bool value)
    {
        invoker.bNOTAUTOAIMED = value;
    }
}

class CloudNotGoneYet : Powerup
{
    Default
    {
        Inventory.ForbiddenTo "PlayerPawn";
        Powerup.Duration -6;
    }
}

class ShroomCloud : PoisonCloud
{
    Default
    {
        Radius 24;
        Height 30;
        Scale 0.7;
        -FOILINVUL;
        -BLOCKEDBYSOLIDACTORS;
        Alpha 0.5;
        ReactionTime 8;
        DeathSound "";
    }

    States
	{
	Spawn:
		TNT1 A 0 A_ScaleVelocity(0);
		PSBG DD 2 A_PoisonBagDamage;
		TNT1 A 0 A_ScaleVelocity(0);
		PSBG EE 2 A_PoisonBagDamage;
		TNT1 A 0 A_ScaleVelocity(0);
		PSBG FFGGGHHHIIIFF 2 A_PoisonBagDamage;
		PSBG F 2 A_PoisonBagDamage;
		PSBG F 1 A_CountDown;
		Goto Spawn+9;
	Death:
		PSBG HG 7;
		PSBG FD 6;
		Stop;
	}
}

//Here's a more deadly version of the ShroomCloud, unfortunately it doesn't work on Hexen
/*Actor ShroomCloud
{
Radius 24
Height 30
Scale 0.7
+NOBLOCKMAP
+NOGRAVITY
+NODAMAGETHRUST
+DONTSPLASH
+CANBLAST
+BLOODLESSIMPACT
RenderStyle Translucent
Alpha 0.5
DamageType PoisonCloud
PoisonDamage 3
PoisonDamageType PoisonCloud
ReactionTime 8
States
	{
	Spawn:
		TNT1 A 0 A_ScaleVelocity(0)
		PSBG DD 2 A_Explode(3,6)
		TNT1 A 0 A_ScaleVelocity(0)
		PSBG EE 2 A_Explode(3,60)
		TNT1 A 0 A_ScaleVelocity(0)
		PSBG FF 2 A_Explode(3,60)
		PSBG GGGHHHIIIFF 2 A_Explode(3,60)
		PSBG F 2 A_Explode(3,60)
		PSBG F 1 A_CountDown
		Goto Spawn+9
	Death:
		PSBG HG 7
		PSBG FD 6
		Stop
	}
}*/

class ShadCastBigMushroom : Actor
{
    Default
    {
        Radius 20;
        Height 46;
        +SOLID
    }

    States
	{
	Spawn:
		MSHR A -1;
		Stop;
	}
}

class SMRandomSpawner : RandomSpawner
{
    Default
    {
        DropItem "SentientMushroom";
        DropItem "ShadCastBigMushroom";
    }
}