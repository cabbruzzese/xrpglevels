class XRpgMinotaurBoss : Minotaur
{
    Default
	{
        Health 6000;
        Scale 2.0;
        Height 160;
        Radius 32;
        Speed 28;
        Damage 12;
        MeleeRange 60;
        DropItem "None";
        +NOICEDEATH
    }

    States
    {
        Death:
            SMT1 Q 6;
            SMT1 R 6 A_Scream();
            SMT1 STU 6;
            SMT1 V 6 A_NoBlocking();
            SMT1 X 12;
            SMT1 Y -1 A_BossDeath();
            Stop;
    }
}

class XRpgMinotaurMinion : Minotaur
{
    int chargeAttempt;
    Default
	{
        Health 650;
        Height 100;
        Radius 22;
        Speed 18;
        Damage 7;
        -BOSS;
        -DONTMORPH;
        -NORADIUSDMG;
        DropItem "None";
        MaxTargetRange 8*64;
        MeleeRange 56;
    }

    States
    {
    Spawn:
		MNTR AB 10 A_MinotaurLook;
		Loop;
	Roam:
		MNTR ABCD 5 A_MinotaurRoam;
		Loop;
	See:
		MNTR ABCD 5 A_MinotaurChase;
		Loop;
	Melee:
		MNTR V 10 A_FaceTarget;
		MNTR W 7 A_FaceTarget;
		MNTR X 12 A_MinotaurAtk1;
		Goto See;
    Missile:
        MNTR A 10 A_MinotaurMinionDecide;
        Goto See;
	Charge:
		MNTR U 2 A_MinotaurMinionCharge;
		Loop;
    ChargeRecover:
        MNTR AE 8;
		MNTR E 14 A_Pain;
        Goto See;
	Pain:
		MNTR E 3;
		MNTR E 6 A_Pain;
		Goto See;
    Death:
        SMT1 Q 6;
        SMT1 R 6 A_Scream();
        SMT1 STU 6;
        SMT1 V 6 A_NoBlocking();
        SMT1 X 12;
        SMT1 Y -1 A_BossDeath();
        Stop;
    }

    void A_MinotaurMinionDecide()
	{
        chargeAttempt = 0;

		if (!target)
          return;

        //50% chance of charging
        if (random[MinotaurCharge](1,2) == 1)
            return;
		
        A_StartSound ("minotaur/sight", CHAN_WEAPON);
        // Charge attack
        // Don't call the state function right away
        SetStateLabel("Charge", true);
        bSkullFly = true;
        bInvulnerable = true;
        
        A_FaceTarget ();
        VelFromAngle(MNTR_CHARGE_SPEED);
        special1 = TICRATE/2; // Charge duration

        chargeAttempt = special1;
	}

    void A_MinotaurMinionCharge()
	{
		if (target == null)
		{
			return;
		}
		if (special1 > 0)
		{
			Class<Actor> type;

			type = "PunchPuff";

			Actor puff = Spawn (type, Pos, ALLOW_REPLACE);
			if (puff != null) puff.Vel.Z = 2;
			special1--;
		}
		else
		{
			bSkullFly = false;
            bInvulnerable = false;

            if (chargeAttempt > 1)
    			SetStateLabel("ChargeRecover", true);
            else
                SetState(SeeState);
		}
	}
}

class MinotaurPriest : MageMonster
{
    Default
    {
        Health 350;
        Radius 24;
        Height 64;
        Speed 8;
        PainChance 50;
        Mass 500;
        MONSTER;
        +FLOORCLIP
        SeeSound "minotaur/sight";
		AttackSound "minotaur/attack1";
		PainSound "minotaur/pain";        
        DeathSound "hellguard/death";
        ActiveSound "hellguard/idle";
        Obituary "%o was fried by a minotaur priest.";
        MeleeDamage 8;
    }
	
    States
    {
    Spawn:
        HLGD AB 10 A_Look;
        Loop;
    See:
        HLGD AABBCCDD 3 A_Chase;
        Loop;
    Missile:        
        HLGD E 8 A_MPriestDecide;
        HLGD F 0 A_Jump(85,4);
        HLGD F 0 A_Jump(128,2);
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, -4, 1);
        Goto Missile+6;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 4, 1);
        Goto Missile+6;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 0, 1);
        Goto Missile+6;
        HLGD E 4 A_FaceTarget;
        HLGD F 0 A_Jump(85,4);
        HLGD F 0 A_Jump(128,2);
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, -4, 1);
        Goto Missile+12;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 4, 1);
        Goto Missile+12;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 0, 1);
        Goto Missile+12;
        HLGD E 4 A_FaceTarget;
        HLGD F 0 A_Jump(85,4);
        HLGD F 0 A_Jump(128,2);
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, -4, 1);
        Goto See;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 4, 1);
        Goto See;
        HLGD F 4 Bright A_SpawnProjectile("MPriestBall", 28, -8, 0, 1);
        Goto See;
    LightningAttack:
        HLGD EF 8 Bright;
        HLGD F 8 Bright A_FireLightning;
        Goto See;
    Pain:
        HLGD G 2;
        HLGD G 2 A_Pain;
        Goto See;
    Death:
        HLGD H 6;
        HLGD I 6 A_Scream;
        HLGD J 6;
        HLGD K 6 A_Fall;
        HLGD LM 6;
        HLGD N -1;
        Stop;
    Raise:
        HLGD ONMLKJI 8;
        Goto See;
    }

    action void A_MPriestDecide()
    {
        if (!target)
            return;
        
        A_FaceTarget();

        double dist = Distance2D(target);
        if (dist < 8*64 && random[MPriestFire](1,2) == 1)
        {
            SetStateLabel("LightningAttack", true);
        }
    }

    action void A_FireLightning()
    {
        let mo = SpawnMissile(target, "MPriestLightningMissile2");
        if (mo)
            mo.target = invoker;
    }
}

class MPriestBall : Actor
{
    Default
    {
        Radius 13;
        Height 8;
        Speed 18;
        Damage 4;
        PROJECTILE;
        RENDERSTYLE "Add";
        ALPHA 0.67;
        SeeSound "hellguard/shot";
        DeathSound "hellguard/shothit";
    }
    
    States
    {
    Spawn:
        HGFB ABCD 2 Bright;
        Loop;
    Death:
        HGFB EFGH 4 Bright;
        Stop;
    }
}

class MPriestLightningFX : MPriestLightningMissile2
{
	Default
	{
        Speed 5;
        Obituary "%o was zapped by a minotaur priest";
	}
}

const MPRIESTLIGHTNING_WOBBLE = 4.0;
const MPRIESTLIGHTNING_DIST = 12.0;
const MPRIESTLIGHTNING_ZSPEED = -90;
class MPriestLightningMissile1 : Actor
{
	Default
	{
		Radius 10;
		Height 6;
		Speed 20;
		FastSpeed 26;
		Damage 4;
		DamageType "Fire";
		Projectile;
		-ACTIVATEIMPACT
		-ACTIVATEPCROSS
		+ZDOOMTRANS
		RenderStyle "Add";
		Obituary "%o was zapped by a minotaur priest.";
	}
	States
	{
	Spawn:
		MLF2 A 6 Bright;
		Loop;
	Death:
		MLF2 BCDE 5 Bright;
		Stop;
	}
}

class MPriestLightningMissile2 : MPriestLightningMissile1
{
	Default
	{
		Radius 5;
		Height 20;
		Speed 20;
		FastSpeed 20;
		Damage 0;
		+CEILINGHUGGER
		RenderStyle "Add";
		
		+RIPPER
	}
	
	states
	{
	Spawn:
		MLF2 AAAAAAAAAAA 2 Bright A_SpellFloorFire;
	Death:
		MLF2 A 6 BRIGHT A_Stop;
        MLF2 BCDE 6 BRIGHT;
		Stop;
	}
	
	void A_SpellFloorFire()
	{
		//Add wobble velocity
		Vel.X += frandom[MPRIESTLIGHTNINGWobble](-MPRIESTLIGHTNING_WOBBLE, MPRIESTLIGHTNING_WOBBLE);
		Vel.Y += frandom[MPRIESTLIGHTNINGWobble](-MPRIESTLIGHTNING_WOBBLE, MPRIESTLIGHTNING_WOBBLE);

		if (!target)
			return;
        
        let mageMonster = MageMonster(target);
        if (!mageMonster)
            return;

		mageMonster.A_FireVerticalMissile("MPriestLightningStrike", MPRIESTLIGHTNING_DIST, MPRIESTLIGHTNING_DIST, MPRIESTLIGHTNING_ZSPEED, Pos.X, Pos.Y);
	}
}

class MPriestLightningSmoke : Actor
{
	Default
	{
	    +NOBLOCKMAP +NOGRAVITY +SHADOW
	    +NOTELEPORT +CANNOTPUSH +NODAMAGETHRUST
		Scale 0.5;
	}
	States
	{
	Spawn:
		MLFX L 12;
		Stop;
	}
}
class MPriestLightningStrike : FastProjectile
{
    Default
    {
        Speed 120;
        Radius 12;
        Height 2;
        Damage 1;
        Projectile;
        +RIPPER
        +CANNOTPUSH +NODAMAGETHRUST
        +SPAWNSOUNDSOURCE
        MissileType "MPriestLightningSmoke";
        DeathSound "MageLightningFire";
        Obituary "$OB_MPMWEAPFROST";

		DamageType "Electric";
    }
    States
    {
    Spawn:
        MLFX K 2 Bright;
		Loop;
    Death:
        MLFX M 2 Bright;
        Stop;
    }
}