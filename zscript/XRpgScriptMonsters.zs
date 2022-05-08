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
                scriptNum = 214;
            
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
    }
    override int TakeSpecialDamage(Actor inflictor, Actor source, int damage, Name damagetype)
    {
        let playerObj = PlayerPawn(source);
        if (damage > 0 && playerObj && playerObj.health > 0)
        {
            int scriptNum = Args[0];
            if (scriptNum == 0)
                scriptNum = 215;
            
            ACS_Execute(scriptNum);
        }

        return damage;
    }
}