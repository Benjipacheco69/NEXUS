using System;

namespace POO_Nexus
{
    internal class Program
    {
        static void Main(string[] args)
        {
            Console.WriteLine("=== NEXUS v2.0 ===");

            Console.Write("Ingrese su nombre: ");
            string nombre = Console.ReadLine();

            Console.Write("Ingrese su edad: ");
            int edad = int.Parse(Console.ReadLine());

            Console.Write("Ingrese energía inicial (0-100): ");
            int energia = int.Parse(Console.ReadLine());

            Console.Write("Ingrese estabilidad inicial (0-100): ");
            int estabilidad = int.Parse(Console.ReadLine());

            // Creamos el objeto Explorador con los datos ingresados
            Explorador jugador = new Explorador(nombre, edad, energia, estabilidad);

            if (edad < 18 || energia < 30 || estabilidad < 40)
            {
                Console.WriteLine(">> Inmersión rechazada. Requisitos: edad >=18, energía >=30, estabilidad >=40.");
                return;
            }

            Console.WriteLine(">> Bienvenido, " + nombre + ". Inmersión autorizada.");

            int opcion = 0;

            while (jugador.GetEnergia() > 0 && jugador.GetEstabilidad() > 0 && opcion != 6)
            {
                Console.WriteLine("\n--- MENU ---");
                Console.WriteLine("1. Explorar realidad");
                Console.WriteLine("2. Analizar anomalia");
                Console.WriteLine("3. Recuperar energia");
                Console.WriteLine("4. Mostrar estado");
                Console.WriteLine("5. Mostrar mapa de realidades");
                Console.WriteLine("6. Salir");
                Console.Write("Seleccione una opcion: ");
                opcion = int.Parse(Console.ReadLine());

                if (opcion == 1)
                {
                    jugador.Explorar();
                }
                else if (opcion == 2)
                {
                    jugador.AnalizarAnomalia();
                }
                else if (opcion == 3)
                {
                    jugador.RecuperarEnergia();
                }
                else if (opcion == 4)
                {
                    jugador.MostrarEstado();
                }
                else if (opcion == 5)
                {
                    jugador.MostrarMapa();
                }
                else if (opcion == 6)
                {
                    Console.WriteLine(">> Desconexion segura. Fin de la sesion.");
                }
                else
                {
                    Console.WriteLine("Opcion invalida.");
                }

                if (jugador.GetEnergia() <= 0)
                {
                    Console.WriteLine(">> Te quedaste sin energia. Fin de la sesion.");
                }
                if (jugador.GetEstabilidad() <= 0)
                {
                    Console.WriteLine(">> Estabilidad critica. Fin de la sesion.");
                }
            }
        }
    }

    // ---------------------------------------------------
    // Clase Mapa: guarda y dibuja el mapa de realidades.
    // Es un objeto separado del Explorador (POO: cada
    // clase se encarga de UNA cosa).
    // ---------------------------------------------------
    class Mapa
    {
        private char[,] celdas;
        private int filas;
        private int columnas;

        // Constructor: se ejecuta al crear un Mapa nuevo
        public Mapa(int filas, int columnas)
        {
            this.filas = filas;
            this.columnas = columnas;
            celdas = new char[filas, columnas];

            // Llenamos el mapa con '-' al inicio
            for (int i = 0; i < filas; i++)
            {
                for (int j = 0; j < columnas; j++)
                {
                    celdas[i, j] = '-';
                }
            }
        }

        // Marca con una 'X' la celda correspondiente a la profundidad actual
        public void Marcar(int profundidad)
        {
            int fila = (profundidad - 1) / columnas;
            int columna = (profundidad - 1) % columnas;

            if (fila < filas)
            {
                celdas[fila, columna] = 'X';
            }
        }

        public void Mostrar()
        {
            Console.WriteLine("\n=== MAPA DE REALIDADES ===");
            for (int i = 0; i < filas; i++)
            {
                for (int j = 0; j < columnas; j++)
                {
                    Console.Write(celdas[i, j] + " ");
                }
                Console.WriteLine();
            }
        }
    }

    // ---------------------------------------------------
    // Clase Explorador: representa al jugador.
    // Tiene un Mapa "adentro" (relacion entre objetos).
    // ---------------------------------------------------
    class Explorador
    {
        // Atributos privados (encapsulamiento):
        // no se pueden tocar directamente desde afuera de la clase
        private string nombre;
        private int edad;
        private int energia;
        private int estabilidad;
        private int profundidad;
        private int pistasIris;
        private Mapa mapaRealidades;

        // Constructor
        public Explorador(string nombre, int edad, int energia, int estabilidad)
        {
            this.nombre = nombre;
            this.edad = edad;
            this.energia = energia;
            this.estabilidad = estabilidad;
            this.profundidad = 0;
            this.pistasIris = 0;
            this.mapaRealidades = new Mapa(3, 3);
        }

        public void Explorar()
        {
            profundidad = profundidad + 1;
            energia = energia - 10;
            estabilidad = estabilidad - 5;
            mapaRealidades.Marcar(profundidad);
            Console.WriteLine(nombre + " exploro una realidad. Profundidad: " + profundidad);
        }

        public void AnalizarAnomalia()
        {
            energia = energia - 8;

            if (pistasIris < 3)
            {
                pistasIris = pistasIris + 1;
                Console.WriteLine("Encontraste una pista de IRIS (" + pistasIris + "/3).");
            }
            else
            {
                Console.WriteLine("Ya reuniste todas las pistas.");
            }
        }

        public void RecuperarEnergia()
        {
            energia = energia + 15;
            if (energia > 100)
            {
                energia = 100;
            }
            Console.WriteLine("Recuperaste energia.");
        }

        public void MostrarEstado()
        {
            Console.WriteLine("\n=== ESTADO DEL EXPLORADOR ===");
            Console.WriteLine("Nombre: " + nombre);
            Console.WriteLine("Edad: " + edad);
            DibujarBarra("Energia", energia);
            DibujarBarra("Estabilidad", estabilidad);
            Console.WriteLine("Profundidad: " + profundidad);
            Console.WriteLine("Pistas IRIS: " + pistasIris);
        }

        public void MostrarMapa()
        {
            mapaRealidades.Mostrar();
        }

        private void DibujarBarra(string etiqueta, int valor)
        {
            int bloques = valor / 5;
            Console.Write(etiqueta + ": [");
            for (int i = 0; i < 20; i++)
            {
                if (i < bloques)
                {
                    Console.Write("#");
                }
                else
                {
                    Console.Write("-");
                }
            }
            Console.WriteLine("] " + valor + "/100");
        }

        // Metodos publicos para leer los atributos privados desde afuera
        public int GetEnergia()
        {
            return energia;
        }

        public int GetEstabilidad()
        {
            return estabilidad;
        }

        public int GetProfundidad()
        {
            return profundidad;
        }
    }
}