class GluttonyVial : CrystalVial
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            int scriptNum = Args[0];
            if (scriptNum == 0)
                scriptNum = SCRIPT_GLUTTONY_VIAL; //Script reserved for gluttony vial

            ACS_Execute(scriptNum); 
        }

        return success;
    }
}

class GreedUrn : ArtiSuperHealth
{
    override bool TryPickup (in out Actor other)
    {
        int scriptNum = Args[0];
        if (scriptNum == 0)
            scriptNum = SCRIPT_GREED_URN; //Script reserved for greed urn

        ACS_Execute(scriptNum); 

        Destroy();
        return false;
    }
}

class GreedWings : ArtiFly
{
    override bool TryPickup (in out Actor other)
    {
        int scriptNum = Args[0];
        if (scriptNum == 0)
            scriptNum = SCRIPT_GREED_WINGS; //Script reserved for greed wings

        ACS_Execute(scriptNum); 

        Destroy();
        return false;
    }
}

class GreedCoin : Inventory
{
    int coinTimer;
    Property CoinTimer : coinTimer;
    default
    {
	    Radius 20;
	    Height 32;
        Inventory.Icon "MNYICON";
        Inventory.PickupMessage "$TXT_ARTIPUZZGREEDCOIN";
        Tag "$TAG_ARTIPUZZGREEDCOIN";
        +FLOATBOB;

        +NOGRAVITY
		+INVENTORY.INVBAR
		Inventory.UseSound "PuzzleSuccess";
		Inventory.PickupSound "misc/i_pkup";

        Inventory.MaxAmount 1;
        GreedCoin.CoinTimer 3000;
	}
    States
    {
    Spawn:
        MNY3 ABCDEFGH 4 BRIGHT;
        Loop;
    }

    override void Tick()
    {
        super.Tick();

        if (Owner)
        {
            CoinTimer -= 1;
            if (CoinTimer < 0)
            {
                Owner.A_Print("Your precious coin has vanished. What curse is this?");
                Destroy();
            }
        }
    }

    override bool Use (bool pickup)
	{
		if (!Owner)
            return false;

        Owner.DropInventory(self);

		return false;
	}

    override void UseAll(Actor user)
	{
	}

    override bool TryPickup(in out Actor toucher)
    {
        let serpent = GreedSerpent(toucher);
        if (serpent)
        {
            serpent.GetCoin();
            Destroy();
            return false;
        }

        return super.TryPickup(toucher);
    }
}

class GasVial : CrystalVial
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            A_StartSound("PoisonShroomDeath");
            Actor mo = Spawn("PoisonLeaderCloud", pos + (0, 0, 28), ALLOW_REPLACE);
        }

        return success;
    }
}

class GasBlueMana : Mana1
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            A_StartSound("PoisonShroomDeath");
            Actor mo = Spawn("PoisonLeaderCloud", pos + (0, 0, 28), ALLOW_REPLACE);
        }

        return success;
    }
}

class GasGreenMana : Mana2
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            A_StartSound("PoisonShroomDeath");
            Actor mo = Spawn("PoisonLeaderCloud", pos + (0, 0, 28), ALLOW_REPLACE);
        }

        return success;
    }
}

class GasCombinedMana : Mana3
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            A_StartSound("PoisonShroomDeath");
            Actor mo = Spawn("PoisonLeaderCloud", pos + (0, 0, 28), ALLOW_REPLACE);
        }

        return success;
    }
}