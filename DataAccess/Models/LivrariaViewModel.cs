namespace DataAccess.Models
{
    public class LivrariaViewModel : PadraoViewModel
    {
        public string Nome { get; set; }
        public string CNPJ { get; set; }
        public string CEP { get; set; }
        public string UF { get; set; }
        public string Cidade { get; set; }
        public string Bairro { get; set; }
        public string Logradouro { get; set; }
        public string Numero { get; set; } = null;

    }
}
