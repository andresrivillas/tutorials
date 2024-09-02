class CarProductionLine {
    setAirBags(airBagsNumber){
        throw new Error("Method not implemented");
    }
    setColor(color){
        throw new Error("Method not implemented");
    }
    setEdition(edition){
        throw new Error("Method not implemented");
    }
    resetProductionLine(){
        throw new Error("Method not implemented");
    }
}

class SedanProductionLine extends CarProductionLine {
    constructor() {
        super();
    }

    setAirBags(howMany) {
        this.sedanCar.airBagsNumber = howMany;
    }
}