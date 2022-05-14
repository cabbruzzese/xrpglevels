const SCRIPT_GLUTTONY_VIAL = 213;
const SCRIPT_PRIDE_ETTIN = 214;
const SCRIPT_PRIDE_DEMON = 215;
const SCRIPT_GREED_URN = 216;
const SCRIPT_GREED_WINGS = 217;
const SCRIPT_GREED_SERPENT = 218;
const SCRIPT_NAME_DESIRE_BANSHEE = "BansheeTeleport";

class PrideEttin : Ettin
{
    Default
    {
        +BOSS
        +NOICEDEATH
        +DONTMORPH
        +NOTELEOTHER
    }

    override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
    {
        int retaliation = damage;

        let playerObj = PlayerPawn(source);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            let vecOffset = (Pos.X - playerObj.Pos.X, Pos.Y - playerObj.Pos.Y);
            let attackAngle = Vectorangle(vecOffset.x, vecOffset.y);

            playerObj.Thrust(-25, attackAngle);

            playerObj.A_DamageSelf(retaliation);
        }

        return 0;
    }

    override int DoSpecialDamage(Actor target, int damage, name damagetype)
    {
        if (damage < 1)
            return 0;
        
        let playerObj = PlayerPawn(target);
        if (playerObj && target.health > 0)
        {
            int scriptNum = Args[0];
            if (scriptNum == 0)
                scriptNum = SCRIPT_PRIDE_ETTIN;
            
            ACS_Execute(scriptNum);

            A_DamageSelf(1000000);
        }

        return 0;
    }
}

class PrideDaemon : Dragon
{
    Default
    {
        +NOTELEOTHER
        +DONTMORPH
    }
    override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
    {
        let playerObj = PlayerPawn(source);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            int scriptNum = Args[0];
            if (scriptNum == 0)
                scriptNum = SCRIPT_PRIDE_DEMON;
            
            ACS_Execute(scriptNum);
        }

        return damage;
    }
}

class GreedSerpent : Demon1
{
    Default
    {
        +BOSS
        +NOICEDEATH
        +DONTMORPH
        +NOTELEOTHER
        +PICKUP
    }

    override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
    {
        int retaliation = damage;

        let playerObj = PlayerPawn(source);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            let vecOffset = (Pos.X - playerObj.Pos.X, Pos.Y - playerObj.Pos.Y);
            let attackAngle = Vectorangle(vecOffset.x, vecOffset.y);

            playerObj.Thrust(-25, attackAngle);

            playerObj.A_DamageSelf(retaliation);
        }

        return 0;
    }

    void GetCoin()
    {
        A_DamageSelf(1000000);
        int scriptNum = Args[0];
        if (scriptNum == 0)
            scriptNum = SCRIPT_GREED_SERPENT;
        
        ACS_Execute(scriptNum);
    }
}

class DesireBanshee : Actor
{
    Default
    {
        Health 300;
        Radius 15;
        Height 60;
        Mass 50;
        Speed 8;
        PainChance 100;
        +FLOAT
        +NOGRAVITY
        +NOTARGET
        +NOBLOOD
        +BOSS
        +NOTELEOTHER
        +DONTMORPH
        +NOICEDEATH
        SeeSound "Banshee/Sight";
        PainSound "Banshee/Pain";
        DeathSound "Banshee/Death";
        ActiveSound "Banshee/Active";
        MeleeSound "Banshee/Raise";
        Monster;
        Obituary "%o Heard The Banshee's Wail";
    }
    
    States
    {
    Spawn:
        BANS A 1 A_Look;
        Loop;
    See:
        BANS A 1;
        BANS A 1;
        BANS A 1 A_UnSetInvulnerable;
        BANS A 1 A_VileChase;
        BANS A 1 A_SpawnItem("BansheeTrail",0,0);
        BANS A 0 A_Jump(20,"BansheeTeleport");
        Loop;
    Missile:
        BANS A 0 A_Jump(128,"Missile2");
        BANS A 0 A_Jump(128,"Missile3");
        Goto See;
    Missile2:  
        BANS B 0 A_FaceTarget;
        BANS BCD 6;
        BANS D 0 A_CustomMissile("BansheeFire",  50, 0,   0);
        Goto Missile;
    Missile3:  
        BANS B 0 A_FaceTarget;
        BANS BCD 4;
        BANS B 0 A_Jump(256,"BansheeTeleport");
        Goto See;
    BansheeTeleport:
        BANS A 0 A_SetInvulnerable;
        BANS A 1 A_SetTranslucent(0.90);
        BANS A 1 A_SetTranslucent(0.80);
        BANS A 1 A_SetTranslucent(0.70);
        BANS A 1 A_SetTranslucent(0.60);
        BANS A 1 A_SetTranslucent(0.50);
        BANS A 1 A_SetTranslucent(0.40);
        BANS A 1 A_SetTranslucent(0.30);
        BANS A 1 A_SetTranslucent(0.20);
        BANS A 1 A_SetTranslucent(0.10);
        BANS A 0 A_Jump(128,25);
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAA 0 A_ExtChase(0,0,1,1);
        TNT1 A 0 A_Jump(128,25);
        TNT1 AAAAAAAAAAAAAAAAAAAAAAAA 0 A_ExtChase(0,0,1,1);
        BANS A 1 A_SetTranslucent(0.10);
        BANS A 1 A_SetTranslucent(0.20);
        BANS A 1 A_SetTranslucent(0.30);
        BANS A 1 A_SetTranslucent(0.40);
        BANS A 1 A_SetTranslucent(0.50);
        BANS A 1 A_SetTranslucent(0.60);
        BANS A 1 A_SetTranslucent(0.70);
        BANS A 1 A_SetTranslucent(0.80);
        BANS A 1 A_SetTranslucent(0.90);
        BANS A 1 A_SetTranslucent(1.0);
        BANS A 0 A_UnSetInvulnerable;
        goto See;
    Pain:
        BANS A 5 ;
        BANS A 5 A_Pain;
        Goto See;
    Death:
        BANS G 6 A_Scream;
        BANS H 6 A_NoBlocking;
        BANS I 3 A_CustomMissile("SpawnFire", 0, 0, 0);
        BANS I 3 A_CustomMissile("SpawnFire", 0, 0, 0);
        BANS IJKLMNOPQR 6;
        BANS R -1;
        Stop;
    }

    void DoScriptCall(Actor targetActor)
    {
        targetActor.ACS_ScriptCall(SCRIPT_NAME_DESIRE_BANSHEE);
    }

    override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
    {
        let playerObj = PlayerPawn(source);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            DoScriptCall(playerObj);
        }

        return 0;
    }

    override int DoSpecialDamage(Actor target, int damage, name damagetype)
    {
        A_PrintBold("Damaged! 111");
        let playerObj = PlayerPawn(target);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            A_PrintBold("Damaged!");
            DoScriptCall(playerObj);
        }

        return damage;
    }
}

class BansheeFire : Actor
{
    Default
    {
        Radius 8;
        Height 8;
        Speed 12;
        Damage 6;
        Projectile;
        +RANDOMIZE
        +RIPPER
        +DEHEXPLOSION
        +ROCKETTRAIL
        SeeSound "Banshee/ASpawn";
        DeathSound "Banshee/ADeath";
        Obituary "%o Heard The Banshee's Wail.";
        Decal "DoomImpScorch";
        DamageType "Fire";
    }
  
    States
    {
    Spawn:
        BANB A 1 BRIGHT A_SpawnItem("BansheeFireTrail",0,0);
        BANB A 4;
        Loop;
    Death:
        BAL1 CDE 3 bright;
        Stop;
    }

    void DoScriptCall(Actor targetActor)
    {
        targetActor.ACS_ScriptCall(SCRIPT_NAME_DESIRE_BANSHEE);
    }

    override int DoSpecialDamage(Actor target, int damage, name damagetype)
    {
        let playerObj = PlayerPawn(target);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            DoScriptCall(playerObj);
        }

        return damage;
    }
}

class BansheeTrail : Actor
{
    Default 
    {
        Radius 20;
        Height 56;
        Speed 0;
        Projectile;
        RenderStyle "Translucent";
        ALPHA 0.90;
    }
   
   States
   {
   Spawn:
        TNT1 A 3;
        BANS A 3 A_FadeOut(0.10);
        goto spawn+1;
   }
}

class BansheeFireTrail : Actor
{
    Default
    {
        Radius 20;
        Height 56;
        Speed 0;
        Projectile;
        RenderStyle "Translucent";
        Scale 0.50;
        ALPHA 0.90;
    }

   States
   {
   Spawn:
      TNT1 A 3;
      BANF ABCDEFGH 3 Bright A_FadeOut(0.10);
      Stop;
   }
}