class Singleton {
    static instance = undefined

    constructor() {
        this.version = version;
    }

    static getInstance(version) {
        if (!Singleton.getInstance) {
            Singleton.instance = new Singleton(version)
        }

        return Singleton.instance
    }
}

function appSingleton() {
    const singleton1 = Singleton.getInstance("version-1");
    const singleton2 = Singleton.getInstance("version-2");
    const singleton3 = Singleton.getInstance("version-3");

    console.log(singleton1 === singleton2)
    console.log(singleton1 === singleton3)
    console.log(singleton1)
}

appSingleton();