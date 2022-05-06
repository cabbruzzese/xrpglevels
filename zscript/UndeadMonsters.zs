//-------------------------------
// Death Knight
//-------------------------------
Class Deathknight : Actor
{
  Default
  {
    Health 600;
    Radius 24;
    Height 72;
    Mass 700;
    Speed 10;
    PainChance 20;
    Obituary "%o thought he could kill a deathknight.";
    HitObituary "A Deathknight hacked %o into pieces.";
    SeeSound "monster/dknsit";
    PainSound "monster/dknpai";
    DeathSound "monster/dkndth";
    ActiveSound "monster/dknact";
    MONSTER;
    +FLOORCLIP
    +NOTARGET
    +NORADIUSDMG
    +MISSILEMORE
    +DEFLECT
    MeleeThreshold 64*5;
  }

  States
  {
  Spawn:
    DKNT AB 10 A_Look();
    Loop;
  See:
    DKNT A 0 A_Jump(32,"See2");
    DKNT A 0 A_UnSetReflectiveInvulnerable();
    DKNT AABBCCDD 3 A_Chase();
    Goto See;
  See2:
    DKNT P 0 A_Jump(8,"See");
    DKNT P 0 A_SetReflectiveInvulnerable();
    DKNT PPQQRRSS 3 A_Chase();
    Loop;
  Melee:
    DKNT E 0 A_UnSetReflectiveInvulnerable();
    DKNT E 6 A_FaceTarget();
    DKNT F 1 A_StartSound ("monster/dknswg");
    DKNT F 6 A_FaceTarget();
    DKNT G 6 A_CustomMeleeAttack(5*random(1, 8), "monster/dknhit");
    Goto See;
  Missile:
    DKNT A 0 A_Jump(48,"Missile2");
    DKNT E 0 Bright A_UnSetReflectiveInvulnerable();
    DKNT E 6 Bright A_FaceTarget();
    DKNT F 6 Bright A_StartSound ("monster/kntswg");
    DKNT G 0 Bright A_SpawnProjectile("DKDart",32,0,-3,0);
    DKNT G 0 Bright A_SpawnProjectile("DKDart",32,0,0,0);
    DKNT G 5 Bright A_SpawnProjectile("DKDart",32,0, 3,0);
    DKNT A 0 A_Jump(8,"Missile2");
    Goto See;
  Missile2:
    DKNT T 0 Bright A_SetReflectiveInvulnerable();
    DKNT T 6 Bright A_FaceTarget();
    DKNT U 6 Bright A_SpawnProjectile("DKbolt",44,-4,0,0);
    DKNT T 6 Bright A_FaceTarget();
    DKNT U 6 Bright A_SpawnProjectile("DKbolt",44,-4,0,0);
    DKNT T 6 Bright A_FaceTarget();
    DKNT U 6 Bright A_SpawnProjectile("DKbolt",44,-4,0,0);
    DKNT U 0 Bright A_UnSetReflectiveInvulnerable();
    Goto See;
  Pain:
    DKNT H 2;
    DKNT H 2 A_Pain();
    DKNT T 105 A_SetReflectiveInvulnerable();
    DKNT T 0 A_UnSetReflectiveInvulnerable();
    DKNT P 0 A_Jump(16, "See");
    Goto See2;
  Death:
    DKNT I 0 Bright A_SpawnProjectile("DKSword", 44, 32,-90,0);
    DKNT I 8 Bright A_SpawnProjectile("DKShield",44,-32, 90,0);
    DKNT J 8 Bright A_Scream();
    DKNT K 8 Bright;
    DKNT L 8 Bright A_NoBlocking();
    DKNT MN 8 Bright;
    DKNT O -1;
    Stop;
  Raise:
    DKNT ONMLKJI 8 Bright;
    Goto See;
  }
}

Class DKSword : Actor
{
  Default
  {
    Radius 8;
    Height 8;
    Speed 1;
    RENDERSTYLE "Normal";
    PROJECTILE;
    -NOGRAVITY
    +LOWGRAVITY
    +ClientSideOnly
  }

  States
  {
  Spawn:
    SWRD KLMNOPQ 3 BRIGHT;
  Death:
    SWRD RS 4 BRIGHT;
    SWRD T 4 BRIGHT;
    SWRD U 4;
    SWRD T 4 BRIGHT;
    SWRD U 8;
    SWRD T 4 BRIGHT;
    SWRD U 16;
    SWRD T 4 BRIGHT;
    SWRD U -1;
    Stop;
  }
}

Class DKShield : Actor
{
  Default
  {
    Radius 8;
    Height 8;
    Speed 1;
    RENDERSTYLE "Normal";
    PROJECTILE;
    -NOGRAVITY
    +LOWGRAVITY
    +ClientSideOnly
  }

  States
  {
  Spawn:
    SHLD ABCDEFGHI 3;
  Death:
    SHLD H -1;
    Stop;
  }
}

Class DKDart : Actor
{
  Default
  {
    Radius 3;
    Height 12;
    Speed 25;
    Damage 5;
    RENDERSTYLE "ADD";
    ALPHA 1.00;
    Seesound "monster/dkndrt";
    DeathSound "weapons/firex2";
    PROJECTILE;
    +THRUGHOST
  }
  States
  {
  Spawn:
    DKAT ABC 3 Bright;
    loop;
  Death:
    DKAT D 3 Bright A_SetTranslucent(0.85,1);
    DKAT E 3 Bright A_Explode(64, 64, 0);
    DKAT FG 3 Bright;
    DKAT HIJKLM 3 Bright;
    stop;
  }
}

Class DKbolt : Actor
{
  Default
  {
    Radius 8;
    Height 8;
    Speed 15;
    Damage 8;
    RENDERSTYLE "Add";
    ALPHA 0.80;
    DamageType "Fire";
    SeeSound "Weapons/boltfi";
    DeathSound "weapons/firex4";
    PROJECTILE;
    +THRUGHOST
  }

  States
  {
  Spawn:
    BOLT A 1 Bright A_BishopMissileWeave();
    BOLT A 0 A_SpawnItem("DKRedPuff",0,0);
    loop;
  Death:
    HBAL EFHI 2 Bright;
    stop;
  }
}

Class DKRedPuff : Actor
{
  Default
  {
    Radius 0;
    Height 1;
    Speed 0;
    RENDERSTYLE "Add";
    ALPHA 0.85;
    PROJECTILE;
    +ClientSideOnly
  }

  States
  {
  Spawn:
    TNT1 A 3 Bright;
    RPUF ABCDE 3 Bright;
    Stop;
  }
}

// End Death Knight

//-------------------------------
// Lost Spirit
//-------------------------------

class LostSpirit : Actor
{
	int user_distance;

    Default
    {
        Health 150;
        Radius 32;
        Height 32;
        Mass 50;
        Speed 16;
        Damage 4;
        Monster;
        +FLOAT
        +NOGRAVITY
        +DONTFALL
        +NOPAIN
        +NOTARGET
        +NOCLIP
        +GHOST
        +NOBLOODDECALS
        +SPAWNFLOAT
        +AVOIDMELEE
        +NOICEDEATH
        SeeSound "LostSpirit/active";
        ActiveSound "LostSpirit/active";
        DeathSound "LostSpirit/death";
        RenderStyle "Translucent";
        Alpha 0.50;
        BloodType "LostSpiritBlood";
        Obituary "%o was scared to death by a Lost Spirit";
    }

	States
	{
	Spawn:
		LSPI AACCBBDD 4 BRIGHT A_Look;
		Loop;
	See:
		LSPI AACCBBDD 4 BRIGHT A_Chase;
		Loop;
	Missile:
		TNT1 A 0 {
            user_distance = 0;
        }
		TNT1 A 0 A_JumpIfCloser(450, 1);
		Goto Charge;
	Charge:	
		TNT1 A 0 A_StartSound ("LostSpirit/charge");
		LSPI D 8 BRIGHT A_FaceTarget;
		LSPI C 0 BRIGHT A_SkullAttack;
		LSPI C 2 BRIGHT A_SpawnItemEx ("LostSpiritTrail", -15);
		TNT1 A 0 {
            user_distance++;
        }
		TNT1 A 0 A_JumpIf(user_distance == 20, "StopCharge");
		Goto Charge+3;
	StopCharge:
		TNT1 A 0 A_Stop;
		Goto See;
	Death:
		LSPI E 6 BRIGHT A_Scream;
		LSPI F 6 BRIGHT;
		LSPI G 6 BRIGHT;
		LSPI H 6 BRIGHT;
		LSPI I 6 BRIGHT;
		LSPI J 6 BRIGHT A_NoBlocking;
		Stop;
	}
}

class LostSpiritTrail : Actor
{
    Default
    {
        Radius 0;
        Height 0;
        Speed 0;
        RenderStyle "Translucent";
        Alpha 0.45;
        +NOCLIP
        +NOGRAVITY
        +NOTELEPORT
    }
	
	States
	{
	Spawn:
		LSPI C 3 BRIGHT A_FadeOut(0.1);
		loop;
	Death:
		stop;
	}
}

class LostSpiritBlood : Actor
{
    Default
    {
        RenderStyle "Translucent";
        Alpha 0.50;
        +NOBLOCKMAP
        +NOTELEPORT
    }
	
	States
	{
	Spawn:
		LSBL CBA 8 BRIGHT A_FadeOut(0.1);
		Stop;
	}
}
// End Lost Spirit

//----------------------------
// Night Shade
//----------------------------
Class Nightshade : Actor
{
    Default
    {
        obituary "%o couldn't escape the Nightshade.";
        health 160;
        radius 20;
        height 56;
        mass 100;
        speed 12;
        painchance 160;
        seesound "monster/nshsit";
        painsound "monster/nshpai";
        deathsound "monster/nshdth";
        activesound "monster/nshact";
        MONSTER;
        
        +FLOAT
        +NOGRAVITY
        +DONTFALL
        +SPAWNFLOAT
        +NOICEDEATH
    }

    states
    {
    Spawn:
        NSHA AB 10 A_Look();
        loop;
    See:
        NSHA A 0 A_SetTranslucent(0.75,0);
        NSHA AABBCCDD 3 A_Chase();
        goto See+1;
    Missile:
        NSHA E 0 A_SetTranslucent(1.0,0);
        NSHA EE 4 Bright A_FaceTarget();
        NSHA F 8 Bright A_SpawnProjectile("ShadeMissile",32,0,0,0,0);
        NSHA B 4 A_SetTranslucent(0.87,0);
        goto See;
    Pain:
        NSHA G 0 A_SetTranslucent(1.0,0);
        NSHA G 2;
        NSHA G 2 A_Pain();
        goto See;
    Death:
        NSHA H 4 A_SetTranslucent(1.0,0);
        NSHA I 4 A_SetTranslucent(0.9,0);
        NSHA I 0 A_Scream();
        NSHA J 4 A_SetTranslucent(0.8,0);
        NSHA K 0 A_NoBlocking();
        NSHA K 4 A_SetTranslucent(0.7,0);
        NSHA L 4 A_SetTranslucent(0.6,0);
        NSHA M 4 A_SetTranslucent(0.5,0);
        NSHA N 4 A_SetTranslucent(0.4,0);
        NSHA O 4 A_SetTranslucent(0.3,0);
        NSHA P 4 A_SetTranslucent(0.2,0);
        stop;
    }
}

Class ShadeMissile : CacodemonBall
{
    Default
    {
        Damage 4;
        Speed 10;
        Alpha 0.80;
        SeeSound "Monster/nshatk";
        DeathSound "Monster/nshexp";
        DamageType "Normal";
        +THRUGHOST
        +SEEKERMISSILE
        +FORCEXYBILLBOARD
    }

    States
    {
    Spawn:
        NBAL A 5 bright A_SpawnItemEx("ShadePuff", 0,0,0, 0,0,0, 0, SXF_CLIENTSIDE);
        NBAL A 0 bright A_Seekermissile(5,7);
        NBAL B 5 bright A_SpawnItemEx("ShadePuff", 0,0,0, 0,0,0, 0, SXF_CLIENTSIDE);
        NBAL B 0 bright A_Seekermissile(5,7);
        loop;
    Death:
        NBAL HIJKLM 3 bright;
        stop;
    }
}

Class ShadePuff : Actor
{
    Default
    {
        Radius 3;
        Height 3;
        RENDERSTYLE "Add";
        Alpha 0.67;
        +NOGRAVITY
        +NOBLOCKMAP
        +DONTSPLASH
        +FORCEXYBILLBOARD
    }

    States
    {
    Spawn:
        TNT1 A 3 Bright;
        NBAL CDEFG 3 BRIGHT;
        Stop;
    }
}
// End Nightshade


//--------------------------
// Fallen
//--------------------------

Class Fallen : Actor
{
    Default
    {
        Health 200;
        Radius 24;
        Height 48;
        Mass 200;
        Speed 12;
        PainChance 128;
        Obituary "%o got burned by a Fallen.";
        SeeSound "monster/falsit";
        PainSound "monster/falpai";
        DeathSound "monster/faldth";
        ActiveSound "monster/falact";
        Monster;
        +NoGravity
        +Float
        +AVOIDMELEE
        +SPAWNFLOAT
        +NOINFIGHTING
        +NOTARGET
        +DONTHARMSPECIES
    }

    States
    {
    Spawn:
        FALN ABCDB 8 Bright A_Look();
        Loop;
    See:
        FALN A 0 Bright A_Jump(96, "FastSee");
        FALN A 1 Bright A_StartSound("monster/falwng");
        FALN AABBCCDDBB 2 Bright A_Chase();
        Loop;
    FastSee:
        FALN B 2 Bright A_Chase(null, "Missile", CHF_FASTCHASE);
        FALN BBB 2 Bright
        {
        A_SpawnItemEx("FallenFX", 0,0,40, 0,0,0, 0, SXF_CLIENTSIDE);
        A_Chase(null, "Missile", CHF_FASTCHASE);
        }
        FALN B 0 Bright A_SpawnItemEx("FallenFX", 0,0,40, 0,0,0, 0, SXF_CLIENTSIDE);
        FALN B 0 Bright A_Jump(64, 1);
        Goto See;
        FALN B 2 Bright A_Chase(null, "Missile", CHF_FASTCHASE);
        FALN BBB 2 Bright
        {
        A_SpawnItemEx("FallenFX", 0,0,40, 0,0,0, 0, SXF_CLIENTSIDE);
        A_Chase(null, "Missile", CHF_FASTCHASE);
        }
        FALN B 0 Bright A_SpawnItemEx("FallenFX", 0,0,40, 0,0,0, 0, SXF_CLIENTSIDE);
        Goto See;
    Missile:
        FALN C 0 Bright A_Jump(96, "Missile2");
        FALN CE 2 Bright A_FaceTarget();
        FALN F 3 Bright A_SpawnProjectile("FallenShot",40,0,0);
        FALN E 5 Bright;
        Goto See;
    Missile2:
        FALN A 2 A_StartSound ("monster/falact");
        FALN A 2 A_Stop;
		FALN AAA 2 BRIGHT A_FaceTarget;
		FALN CCCCC 4 BRIGHT A_FloorFire;
        FALN C 2 A_Stop;
            Goto See;
    Pain:
        FALN E 3 Bright;
        FALN E 3 Bright A_Pain();
        FALN E 3 Bright;
        Goto See;
    Death:
        FALN G 5 Bright;
        FALN H 5 Bright A_Scream();
        FALN IJK 5 Bright;
        FALN L 5 Bright A_NoBlocking();
        FALN M -1 A_SetFloorClip();
        Stop;
    Raise:
        FALN M 5 A_UnSetFloorClip();
        FALN LKJIHG 5 Bright;
        Goto See;
    }

    action void A_FloorFire()
    {
        Thrust(7, angle);

        let mo = A_SpawnProjectile("FallenFXFloor",0,0,0);
        if (mo)
        {
            mo.Vel.X = MinVel; // Force collision detection
            mo.Vel.Y = MinVel; // Force collision detection
            mo.Vel.Z = -90;
            mo.CheckMissileSpawn (radius);
        }
    }
}

Class FallenFX : Actor
{
  Default
  {
    Radius 2;
    Height 2;
    Speed 0;
    RenderStyle "Add";
    Alpha 0.67;
    Projectile;
  }

  States
  {
  Spawn:
    TNT1 A 3 Bright;
    FBFX ABCDE 3 Bright;
    Stop;
  }
}

Class FallenShot : Actor
{
  Default
  {
    Radius 8;
    Height 8;
    Speed 16;
    Damage 2;
    RenderStyle "Add";
    DamageType "Fire";
    Alpha 0.67;
    Seesound "weapons/firmfi";
    DeathSound "weapons/firex5";
    Projectile;
    +ThruGhost
  }

  States
  {
  Spawn:
    BALF AB 2 Bright A_SpawnItemEx("FallenFX", 0,0,0, 0,0,0, 0, SXF_CLIENTSIDE);
    Loop;
  Death:
    BALF CDEF 4 Bright;
    Stop;
  }
}

Class FallenSP : Actor
{
  Default
  {
    Radius 2;
    Height 2;
    Speed 0;
    ReactionTime 60;
    RenderStyle "Normal";
    Projectile;
    -NoGravity
  }

  States
  {
  Spawn:
    FBSP AB 3 Bright A_Countdown();
    Loop;
  Death:
    FBSP CDE 3 Bright;
    Stop;
  }
}

class FallenFXFloor : Actor
{
    Default
    {
        Radius 8;
        Height 8;
        Speed 0;
        Damage 2;
        RenderStyle "Add";
        DamageType "Fire";
        DeathSound "MaulatorMissileHit";
        Projectile;
        +ThruGhost
        -ACTIVATEIMPACT
		-ACTIVATEPCROSS
        +RIPPER
    }

    States
    {
    Spawn:
        TNT1 A 2;
        Loop;
    Death:
        FX13 I 6 BRIGHT A_Explode(55, 80, 0);
        FX13 JKLM 6 BRIGHT;
		FX13 M 1 BRIGHT;
		Stop;
    }
}
// End Fallen

//---------------------------
//Scimitar
//---------------------------
class Scimitar : Actor
{
    Default
    {
        Health 250;
        PainChance 85;
        Speed 20;
        Radius 16; 
        Height 32;
        Mass 25;
        Alpha .5;
        MeleeDamage 2;
        MeleeRange 96;
        Monster;
        +FLOORCLIP
        +DONTHARMSPECIES
        +NOGRAVITY
        +FLOAT
        +NOBLOOD
        +NOICEDEATH
        SeeSound "scimitar/scimisee";
        PainSound "scimitar/scimipai";
        DeathSound "scimitar/scimidth";
        Obituary "%o was sliced by a Scimitar.";
        DamageFactor "poison", 0.0;
        DamageFactor "poisoncloud", 0.0;
        DamageFactor "electric", 2.0;
        DamageFactor "fire", 0.5;
        MaxTargetRange 6*64;
    }
   

    States 
    { 
    Spawn: 
        SCIM B 6 BRIGHT A_SetInvulnerable;
        SCIM BBBBBB 2 BRIGHT AddZ(8);
        SCIM C 6 A_UnSetInvulnerable;
    SpawnLoop:
        SCIM A 3 BRIGHT A_Look;
        Goto SpawnLoop;
    See: 
        SCIM A 3 BRIGHT A_Chase;
        Loop;
    Melee:
        SCIM C 4 BRIGHT A_FaceTarget;
        SCIM A 4 BRIGHT;
        SCIM B 4 BRIGHT A_CustomMeleeAttack(random(1, 8), "scimitar/scimihit");
        Goto See;
    Pain:  
        SCIM F 6 BRIGHT A_Pain;
        Goto See;
    Death: 
        SCIM G 6 BRIGHT A_Scream;
        SCIM H 6 BRIGHT A_NoBlocking;
        SCIM I 6 BRIGHT;
        SCIM J 6 BRIGHT;
        SCIM K 6 BRIGHT;
        SCIM L -1;
        Stop;
    Missile:
    Charge:
        SCIM F 4 A_ChargeAndAttack;
        SCIM F 4 A_ChargeAndAttack;
        SCIM F 4 A_ChargeAndAttack;
        SCIM F 4 A_ChargeAndAttack;
        SCIM F 4 A_ChargeAndAttack;
        SCIM F 0 A_Stop;
        Goto Melee;
    Raise:
        SCIM BCA 5;
        Goto See;
    }

    action void A_ChargeAndAttack()
    {
        A_FaceTarget();
        A_SkullAttack();
        A_CustomMeleeAttack(random(1, 8), "scimitar/scimihit");
    }
}
// end Scimitar

//---------------------------
// Invisible Warrior
//---------------------------

class InvisibleWarrior : Actor
{
    Default
    {
        obituary "%o was killed by an invisible warrior.";
        health 640;
        radius 30;
        height 64;
        mass 340;
        speed 12;
        painchance 60;
        MeleeRange 128;
        MeleeThreshold 64*3;
        PainSound "Invisiblepain";
        ActiveSound "Invisiblesee";
        DeathSound "Invisibledeath";
        MeleeSound "Invisiblehit";
        Monster;
        +FLOORCLIP
        +NODROPOFF
        +NOICEDEATH
    }
  
    States
    {
    Spawn:
        INVW A 10 A_Look;
        loop;
    See:
        INVW AABBCCDD 3 A_Chase;
        loop;
    Melee:
        INVW EF 6;
        INVW G 8 A_CustomMeleeAttack(random(1, 8), "monster/dknhit");
        INVW EF 6;
        INVW G 8 A_CustomMeleeAttack(random(1, 8), "monster/dknhit");
        INVW EEE 6;
        INVW F 4 A_StartSound("Invisiblehit");
        INVW G 24
        {
            A_CustomMeleeAttack(5*random(1, 8), "monster/dknhit");
            for (int i = 0; i < 8; i++)
            {
                A_SpawnProjectile("InvisibleelTrail", Pos.Z + (Height / 2),0,random(0,255),CMF_AIMDIRECTION,random(0,255));
            }
        }
        goto See;
    Missile:
        INVW EEE 6 A_ChargeSparks;
        INVW F 4 A_StartSound("Invisiblehit");
        INVW G 8 A_SpawnProjectile("InvisibleAttackFX",48,0);
        goto See;
    Pain:
        TNT1 A 0 A_FaceTarget;
        INVW H 2 ThrustThing(angle*256/360+random(96,160), 4, 0, 0);
        INVW H 2 A_Pain;
        TNT1 A 0 A_FadeOut(0.03, 0);
        goto See;
    Death:
        INVB A 5;
        INVB B 5 A_Scream;
        INVB C 5;
        INVB D 5 A_NoBlocking;
        INVB EFGHIJ 8;
        INVB K 8 A_DropScimitar;
        INVB LLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLLL 1 A_FadeOut(0.01, 0);
        stop;
    }

    action void A_ChargeSparks()
    {
        A_FaceTarget();
        for (int i = 0; i < 4; i++)
        {
            A_SpawnProjectile("InvisibleelTrail", Pos.Z + (Height),0,random(0,255),CMF_AIMDIRECTION,random(0,255));
        }
    }

    action void A_DropScimitar()
    {
        let mo = Spawn("Scimitar", (Pos.X, Pos.Y, Pos.Z), NO_REPLACE);
        if (mo)
        {
            mo.target = target;
            mo.angle = angle;
        }
    }
}

class InvisibleAttackFX : Actor
{
    Default
    {
        Speed 15;
        Radius 10;
        Height 6;
        Damage 5;
        Projectile;
        +SPAWNSOUNDSOURCE
        RenderStyle "Add";
        ExplosionRadius 1500;
        ExplosionDamage 60;
        SeeSound "elect1";
        DeathSound "elect1";
    }
  
    States
    {
    Spawn:
        DAXD RRRRSSSSTTTTSSSSRRRRSSSSTTTTSSSSR 1 Bright A_SpawnProjectile("InvisibleelTrail",0,0,0,CMF_AIMDIRECTION,random(-10,10));
    Death:
        TNT1 A 0 A_ChangeVelocity(Vel.X*0.5, Vel.Y*0.5, Vel.Z, CVF_REPLACE);
        DAXD RRRSSSTTTUUU 1 Bright A_SpawnProjectile("InvisibleelTrail",0,0,random(0,255),CMF_AIMDIRECTION,random(0,255));
        DAXD VWX 3 Bright;
        stop;
    }
}

class InvisibleelTrail : Actor
{
    Default
    {
        Radius 3;
        Height 3;
        Scale 0.75;
        Speed 12;
        Projectile;
        +NOCLIP
        RenderStyle "Add";
        Alpha 0.67;
    }

   
    States
    {
    Spawn:
            DAXD R 3 Bright A_StartSound("elect2");
            DAXD RSTU 3 Bright A_FadeOut(0.1);
            DAXD VWX 3 BRIGHT A_FadeOut(0.1);
            stop;
    }
}
