use EWord::M::DictScraper2;
use EWord::M::DictAPI;
use Data::Dumper;

#my $defines = EWord::M::DictScraper2->scrape("clarifies");
my $defines = EWord::M::DictAPI->get_def("wn", "hypothesis");
warn Dumper $defines;
