class IslandData{

  var islandName = [
    '기회의 섬', //island_00.jpg
    '하모니 섬', //island_01.jpg
    '포르페',  //island_02.jpg
    '볼라르 섬', //island_03.jpg
    '메데이아', //island_04.jpg
    '몬테 섬', //island_05.jpg
    '수라도', //island_06.jpg
    '고요한 안식의 섬', //island_07.jpg
    '죽음의 협곡', //island_08.jpg
    '블루홀 섬' , //island_09.jpg
    '쿵덕쿵 아일랜드', //island_010.jpg
    '스노우팡 아일랜드', //island_011.jpg
    '환영 나비의 섬', //island_012.jpg
    '우거진 갈대의 섬', //island_013.jpg
    '잔혹한 장난감 성', //island_014.jpg
  ];

  var islandReward = [
    '태양의 가호', //island_r0.jpg
    '골드', //island_r1.jpg
    '실링', //island_r2.jpg
    '파괴석 결정', //island_r3.jpg
    '명예의 파편', //island_r4.jpg
    '주화',  //island_r5.jpg
    '카드', //island_r6.jpg
    '', //island_r7.jpg (none)
  ];

  Map islandNameMap = {};
  Map islandRewardMap = {};


  String selectIslandName(String data) {
    islandNameMap[islandName[0]] = 'island_00.jpg';
    islandNameMap[islandName[1]] = 'island_01.jpg';
    islandNameMap[islandName[2]] = 'island_02.jpg';
    islandNameMap[islandName[3]] = 'island_03.jpg';
    islandNameMap[islandName[4]] = 'island_04.jpg';
    islandNameMap[islandName[5]] = 'island_05.jpg';
    islandNameMap[islandName[6]] = 'island_06.jpg';
    islandNameMap[islandName[7]] = 'island_07.jpg';
    islandNameMap[islandName[8]] = 'island_08.jpg';
    islandNameMap[islandName[9]] = 'island_09.jpg';
    islandNameMap[islandName[10]] = 'island_010.jpg';
    islandNameMap[islandName[11]] = 'island_011.jpg';
    islandNameMap[islandName[12]] = 'island_012.jpg';
    islandNameMap[islandName[13]] = 'island_013.jpg';
    islandNameMap[islandName[14]] = 'island_014.jpg';

    return islandNameMap[data] ;
  }

  String selectIslandReward(String data) {
    islandRewardMap[islandReward[0]] = 'island_r0.jpg';
    islandRewardMap[islandReward[1]] = 'island_r1.jpg';
    islandRewardMap[islandReward[2]] = 'island_r2.jpg';
    islandRewardMap[islandReward[3]] = 'island_r3.jpg';
    islandRewardMap[islandReward[4]] = 'island_r4.jpg';
    islandRewardMap[islandReward[5]] = 'island_r5.jpg';
    islandRewardMap[islandReward[6]] = 'island_r6.jpg';
    islandRewardMap[islandReward[7]] = 'island_r7.jpg';

    return islandRewardMap[data];
  }
}
