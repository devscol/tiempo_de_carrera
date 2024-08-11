import Array "mo:base/Array";
import Debug "mo:base/Debug";

actor Main {
    // Define un alias para claridad
    type RunnerTime = { 
        runner: Text; 
        time: Float
         };

    // Crea un array mutable para almacenar los tiempos de los corredores
    var times : [RunnerTime] = [];

    // Función para añadir el tiempo de un corredor
    public func addTime(runner: Text, time: Float) : async () {
        if (Array.size(times) < 10) {
            times := Array.append(times, [{ runner; time }]);
        } else {
            Debug.print("No se pueden añadir más de 10 corredores.");
        }
    };

    // Función para obtener los tres primeros corredores
    public func getTopThree() : async [RunnerTime] {
        // Ordena el array por tiempo en orden ascendente
        let sortedTimes = Array.sort<RunnerTime>(times, func (a, b) : {#equal; #greater; #less} {
            if (a.time < b.time) {
                return #less;
            } else if (a.time > b.time) {
                return #greater;
            } else {
                return #equal;
            }
        });

        // Obtén los tres primeros corredores
        let topThreeSize = if (Array.size(sortedTimes) < 3) {
            Array.size(sortedTimes)
        } else {
            3
        };

        return Array.subArray(sortedTimes, 0, topThreeSize);
    };

    // Función para ejecutar la carrera y mostrar los resultados
    public func runRace() : async () {
        // Añadir tiempos de los corredores
        await addTime("Corredor 1", 12.5);
        await addTime("Corredor 2", 11.3);
        await addTime("Corredor 3", 14.1);
        await addTime("Corredor 4", 10.9);
        await addTime("Corredor 5", 13.6);
        await addTime("Corredor 6", 12.1);
        await addTime("Corredor 7", 11.7);
        await addTime("Corredor 8", 15.0);
        await addTime("Corredor 9", 14.3);
        await addTime("Corredor 10", 13.0);

        // Obtener los tres primeros corredores
        let topThree = await getTopThree();
        
        // Imprimir los resultados
        Debug.print(debug_show(topThree));
    };
}
