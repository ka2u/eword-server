use EWord::M::DictScraper2;
use EWord::M::DictAPI;
use Data::Dumper;

my $defines = EWord::M::DictScraper2->scrape("clarifies");
warn Dumper $defines;
#EWord::M::DictAPI->get_def("wn", "elaborate");
