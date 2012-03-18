# mountains are merely mountains
# this will contain all the tables - bab, save, etc
# as constants - use Tables::Bab etc to access them

module Tables
  SaveBase = {
    good: [].fill(1..20) { |i| (2 + i/2.0).floor },
    medium: [].fill(1..20) { |i| (1 + 5.0*i/12.0).floor },
    poor: [].fill(1..20) { |i| (i/3.0).floor }
  }
  BabBase = {
    good: [].fill(1..20) { |i| i},
    medium: [].fill(1..20) { |i| (3.0*i/4.0).floor },
    poor: [].fill(1..20) { |i| (i/2.0).floor }
  }
  Feats = {
    base: [].fill(1..20) { |i| i%3 == 0 ? 1 : 0},
    fighter: [].fill(1..20) { |i| i%2 == 0 ? 1 : 0},
    human: [nil, 1]
  }
  Class = {
    fighter: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:poor],
      bab: BabBase[:good],
      hitdie: 10,
      },
    barbarian: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:poor],
      bab: BabBase[:good],
      hitdie: 12,
      },
    bard: {
      fort: SaveBase[:poor],
      refl: SaveBase[:good],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    cleric: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    druid: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    monk: {
      fort: SaveBase[:good],
      refl: SaveBase[:good],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    paladin: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:good],
      hitdie: 10,
      },
    ranger: {
      fort: SaveBase[:good],
      refl: SaveBase[:good],
      will: SaveBase[:poor],
      bab: BabBase[:good],
      hitdie: 10,
      },
    rogue: {
      fort: SaveBase[:poor],
      refl: SaveBase[:good],
      will: SaveBase[:poor],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    sorcerer: {
      fort: SaveBase[:poor],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:poor],
      hitdie: 6,
      },
    wizard: {
      fort: SaveBase[:poor],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:poor],
      hitdie: 6,
      },
    alchemist: {
      fort: SaveBase[:good], 
      refl: SaveBase[:good], 
      will: SaveBase[:poor],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    cavalier: {
      fort: SaveBase[:good],
      refl: SaveBase[:poor],
      will: SaveBase[:poor],
      bab: BabBase[:good],
      hitdie: 10,
      },
    gunslinger: {
      fort: SaveBase[:good],
      refl: SaveBase[:good],
      will: SaveBase[:poor],
      bab: BabBase[:good],
      hitdie: 10,
      },
    inquisitor: {
      fort: SaveBase[:good], 
      refl: SaveBase[:poor], 
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    magus: {
      fort: SaveBase[:good], 
      refl: SaveBase[:poor], 
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    oracle: {
      fort: SaveBase[:poor],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    summoner: {
      fort: SaveBase[:poor],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:medium],
      hitdie: 8,
      },
    witch: {
      fort: SaveBase[:poor],
      refl: SaveBase[:poor],
      will: SaveBase[:good],
      bab: BabBase[:poor],
      hitdie: 6,
      },
  }
end