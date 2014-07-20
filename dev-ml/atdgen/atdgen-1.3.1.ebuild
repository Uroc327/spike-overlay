# Copyright 1999-2014 Gentoo Foundation
# Distributed under the terms of the GNU General Public License v2
# $Header: /var/cvsroot/gentoo-x86/dev-ml/extlib/extlib-1.6.1.ebuild,v 1.4 2014/04/13 16:20:44 ago Exp $

EAPI=5

inherit findlib eutils

DESCRIPTION="Adaptable Type Definitions. A syntax for defining cross-language data types."
HOMEPAGE="http://mjambon.com/ocaml.html"
LICENSE="BSD"
DEPEND=">=dev-lang/ocaml-3.11:=[ocamlopt?]
	dev-ml/findlib
	dev-ml/menhir
	dev-ml/easy-format
	dev-ml/camlmix"
RDEPEND="${DEPEND}"
SLOT="0/${PV}"
IUSE="doc +ocamlopt"

if [[ ${PV} != 9999 ]]; then
	SRC_URI="https://github.com/mjambon/${PN}/archive/v${PV}.tar.gz -> ${P}.tar.gz"
	KEYWORDS="amd64 ppc x86 ~amd64-linux ~x86-linux ~ppc-macos"
else
	inherit git-r3
	EGIT_REPO_URI="https://github.com/mjambon/${PN}.git"
fi


src_compile() {
	emake -j1 all
	if use ocamlopt; then
		emake opt
	fi

	if use doc; then
		emake manual
	fi
}

src_install () {
	findlib_src_install

	# install documentation

	if use doc; then
		dohtml doc/*
	fi
}

