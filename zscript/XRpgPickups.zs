class GluttonyVial : CrystalVial
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            ACS_Execute(SCRIPT_GLUTTONY_VIAL); //Script reserved for gluttony vial
        }

        return success;
    }
}

class GreedUrn : ArtiSuperHealth
{
    override bool TryPickup (in out Actor other)
    {
        ACS_Execute(SCRIPT_GREED_URN); //Script reserved for greed urn

        Destroy();
        return false;
    }
}