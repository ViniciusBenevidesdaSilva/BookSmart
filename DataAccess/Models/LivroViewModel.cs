using System.Collections.Generic;

namespace DataAccess.Models
{
    public class LivroViewModel : PadraoViewModel
    {
        public GeneroViewModel Genero { get; set; } = new GeneroViewModel();
        public string Nome { get; set; }
        public string Sinopse { get; set; }
        public string Autor { get; set; }
        public string Editora { get; set; }
        public double Preco { get; set; }
        public int? Ano_publicacao { get; set; }

        public CapaLivroViewModel Capa_Livro { get; set; } = null; // Ele não cria um objeto capa até que seja necessário
        public List<LivroRFIDViewModel> Rfids { get; set; } = new List<LivroRFIDViewModel>();
        public List<AvaliacaoViewModel> Avaliacoes { get; set; } = new List<AvaliacaoViewModel>();
    }
}
