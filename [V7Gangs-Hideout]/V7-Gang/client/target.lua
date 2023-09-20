exports[Config.target]:AddBoxZone("aboa7med:vp7ru:v7:first:target", vector3(-25.31, -1413.83, 29.51), 0.8, 3.8, {
name = "aboa7med:vp7ru:v7:first:target",
heading = 2.5,
minZ=28.51,
maxZ=30.71
}, {

    options = {
        {
            type = "client",
            event = "first:menu:aboa7med:v7:gang",
            icon = "fas fa-sign-in-alt",
            label = "شراء الاسلحة"
        },        
    },
    distance = 2.5
})

exports[Config.target]:AddBoxZone("aboa7med:vp7ru:v7:first:target3", vector3(-30.59, -1414.74, 29.51), 2.6, 4.0, {
    name = "aboa7med:vp7ru:v7:first:target3",
    heading = 2.5,
    minZ=28.51,
    maxZ=30.51
    }, {
    
        options = {
            {
                type = "client",
                event = "v7:gang:stash",
                icon = "fas fa-sign-in-alt",
                label = "الخزنة",
            },        
        },
        distance = 2.5
    })

exports[Config.target]:AddBoxZone("aboa7med:vp7ru:v7:first:target4", vector3(-27.66, -1399.75, 29.51), 1.6, 1.0, {
name = "aboa7med:vp7ru:v7:first:target4",
heading = 2.5,
minZ=28.51,
maxZ=30.51
}, {

    options = {
        {
            type = "client",
            event = "v7:gang:money:client",
            icon = "fas fa-sign-in-alt",
            label = "غسيل الاموال",
        },        
    },
    distance = 2.5
})

exports[Config.target]:AddBoxZone("aboa7med:vp7ru:v7:first:target5", vector3(-27.01, -1412.61, 29.51), 0.8, 1.0, {
name = "aboa7med:vp7ru:v7:first:target5",
heading = 40,
minZ=28.51,
maxZ=30.51
}, {

    options = {
        {
            type = "client",
            event = "v7:gang:vehicle",
            icon = "fas fa-sign-in-alt",
            label = "استخراج المركبة",
        },        
    },
    distance = 2.5
})

exports[Config.target]:AddBoxZone("aboa7med:vp7ru:v7:first:target2", vector3(-21.16, -1394.01, 33.14), 2.4, 2.4, {
name = "aboa7med:vp7ru:v7:first:target2",
heading = 0,
minZ=32.14,
maxZ=33.54
}, {

options = {
    {
        type = "client",
        event = "two:menu:aboa7med:v7:gang",
        icon = "fas fa-sign-in-alt",
        label = "كاميرات المراقبة",
    },        
},
distance = 2.5
})