class GluttonyVial : CrystalVial
{
    override bool TryPickup (in out Actor other)
    {
        bool success = super.TryPickup(other);

        if (success)
        {
            ACS_Execute(213); //Script reserved for gluttony vial
        }

        return success;
    }
}