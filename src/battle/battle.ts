export type Spell = (state: BattleState) => void;

export interface Combatant {
    hp: number;
}

export interface Player extends Combatant {
    spells: Array<Spell>;
}

export interface Enemy extends Combatant {
    attacks: { [probability: number]: (player: Player, state: BattleState) => void };
}

export enum FightState { DODGE, CAST };

export interface BattleState {
    fightState: FightState;
    player: Player;
    enemies: Enemy[];
}
