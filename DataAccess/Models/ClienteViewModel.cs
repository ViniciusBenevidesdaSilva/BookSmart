using System;

namespace DataAccess.Models
{
    public class ClienteViewModel : PadraoViewModel
    {
        public string Rfid_id { get; set; }
        public UsuarioViewModel Usuario { get; set; } = new UsuarioViewModel();
        public GeneroViewModel Genero { get; set; } = new GeneroViewModel();
        public SexoViewModel Sexo { get; set; } = new SexoViewModel();
        public string Nome { get; set; }
        public string Cpf { get; set; }
        public string Email { get; set; } = null;
        public string Telefone { get; set; } = null;
        public string Endereco { get; set; }
        public DateTime Data_nascimento { get; set; }
        public double Saldo { get; set; }
    }
}
