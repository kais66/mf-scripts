#include <iostream>

//#include "mf.hh"
#include "mfguid.hh"
#include "mftransportheader.hh"
#include "mfroutingheader.hh"

using namespace std;

int main() {
  uint32_t HOP_DATA_PKT_SIZE = 10;
  uint32_t trans_hdr_size = TRANS_BASE_HEADER_SIZE + (20*2 + 4*2);
  uint32_t pkt_size = HOP_DATA_PKT_SIZE + ROUTING_HEADER_SIZE + trans_hdr_size;
  unsigned char *pkt = new unsigned char[pkt_size];
  memset(pkt, 0, pkt_size);

  TransHeader *thdr = TransHeaderFactory::newTransHeader(pkt +
                      HOP_DATA_PKT_SIZE + ROUTING_HEADER_SIZE, STORE_T);

  thdr->setSeq(1).
        setChkSize(1). // dummy number
        setPktCnt(1).
        setStartOffset(0).
        setEndOffset(0).  // because there's only one pkt in this chunk
        setTransFlag(NO_REQUEST).
        setReliabPref(PREF_DONT_CARE).
        setTransOffset(trans_hdr_size).
        setCongNotif(R_NOFEEDBACK).
        setRecvWd(20); // doesn't matter

  cout << "hello" << endl;
  TransStoreHeader *store_thdr = dynamic_cast<TransStoreHeader *>(thdr);
  GUID g, u;
  g.init(1);
  u.init(9);
  store_thdr->setStoreSrcGUID(g).
        setStoreDstGUID(u).
        setNumStoredChk(1);
  cout << "world" << endl;
}
