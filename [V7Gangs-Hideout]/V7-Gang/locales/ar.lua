local Translations = {
    info = {
        spawnveh = 'جاري استخراج المركبة',
    },
    Notify = {
        notify1 = "لايوجد لديك ربطات مال",
        notify2 = "تم اعطائك السلاح",
        notifyError = "لا يوجد لديك مال",
        notify3 = "تم اعطائك 500 من المال",
    }
}

Lang = Locale:new({
    phrases = Translations,
    warnOnMissing = true
})