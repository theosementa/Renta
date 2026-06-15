# Renta — Product Specification

> *Chaque objet que tu possèdes a un coût réel. Renta te le montre.*

---

## Vision

La plupart des gens savent combien ils ont **payé** un objet. Personne ne sait combien il leur **coûte vraiment** — par jour, par mois, au fil du temps.

Renta est une app de suivi du coût d'usage de tes objets. Tu renseignes ce que tu as acheté, quand, pour combien. Renta calcule automatiquement l'amortissement en temps réel et te donne une vision claire de la valeur que tu tires de chaque possession.

Le concept clé : **plus tu utilises un objet longtemps, plus son coût journalier baisse**. Renta rend cette mécanique visible et satisfaisante à suivre.

---

## Cas d'usage principal

> *"J'ai payé mon Mac M1 Max 4 000 € il y a 4 ans. Combien ça m'a coûté au total ? Par jour ? Si je le revends 1 200 €, quel est mon vrai coût ?"*

L'utilisateur ajoute l'objet une fois. Renta fait le reste, en temps réel, pour toujours.

---

## Onboarding

L'onboarding se déroule à la première ouverture de l'app. Il a un seul objectif : faire comprendre la mécanique en moins de 30 secondes et amener l'utilisateur à ajouter son premier objet.

### Étape 1 — Le concept (1 écran)

Un écran d'accroche minimaliste avec une seule phrase et un exemple animé :

> *"Tu sais ce que tu as payé. Renta te dit ce que ça te coûte vraiment."*

Animation : un Mac à 2 500 € dont le coût/jour descend visuellement de 2 500 €/j à 1,20 €/j au fil du temps. Pas de texte superflu. Un bouton *"Commencer"*.

### Étape 2 — Référentiel salaire (1 écran, optionnel)

Deux champs : salaire mensuel net et heures travaillées par semaine. Le sous-titre explique l'utilité en une ligne : *"Pour traduire tes coûts en temps de travail."* Un lien *"Passer"* bien visible — ce n'est jamais bloquant.

### Étape 3 — Notifications (1 écran full screen)

Dans la continuité visuelle des autres écrans d'onboarding :
- Une icône ou illustration légère liée aux milestones
- Un titre court : *"Sois prévenu quand ça s'améliore"*
- Deux ou trois exemples concrets de notifications : milestone d'amortissement, anniversaire de possession, stats disponibles après J+7
- Un bouton primaire *"Activer les notifications"* qui déclenche la popup système iOS
- Un lien secondaire *"Pas maintenant"* qui passe à l'étape suivante sans bloquer

La popup système iOS apparaît uniquement si l'utilisateur appuie sur le bouton primaire — jamais déclenchée directement. Si l'utilisateur refuse via iOS ou passe l'étape, l'app fonctionne normalement ; une invitation discrète pourra réapparaître plus tard depuis les réglages.

### Étape 4 — Premier objet (formulaire d'ajout standard)

L'app ouvre directement le formulaire d'ajout d'objet avec un message contextuel en haut : *"Ajoute un objet que tu possèdes pour voir son coût réel."* Pas d'écran intermédiaire. L'utilisateur arrive directement à l'action.

Une fois le premier objet ajouté, l'app affiche sa fiche avec les stats en temps réel — c'est le moment "aha". L'onboarding est terminé.

### Règles générales

- Maximum 4 étapes, aucune ne peut bloquer l'accès à l'app
- La demande de notifications est un écran full screen dans la continuité de l'onboarding — la popup système iOS n'est jamais déclenchée directement
- Pas de création de compte, pas d'autres permissions demandées à ce stade
- iCloud : si non connecté, la bannière apparaît après l'onboarding, pas pendant

---

## Features

### 1. Ajout d'un objet

L'utilisateur renseigne :

- **Nom** — ex. *MacBook Pro M1 Max*
- **Emoji** — sélecteur emoji pour identifier visuellement l'objet dans les listes. Des suggestions sont proposées automatiquement, l'utilisateur peut en choisir un autre librement via le picker natif iOS
- **Prix d'achat** — ex. *4 000 €*
- **Date d'achat** — ex. *12 mars 2021*. Pré-remplie avec la date du jour, modifiable
- **Durée cible d'amortissement** — l'utilisateur choisit parmi 6 options qualitatives (voir section Score de valeur). Détermine les seuils du score. Obligatoire
- **Tags** (optionnels) — libres, multiples, créés par l'utilisateur. Servent uniquement à filtrer et organiser les objets. N'influencent pas le score. Ex. *Travail*, *Reconditionné*, *Cadeau*
- **Exclure des analyses globales** (toggle, désactivé par défaut) — permet d'exclure l'objet de tous les calculs du tableau de bord global. Utile pour des objets atypiques comme une voiture dont le coût/jour fausserait la lecture de l'ensemble. L'objet reste visible et ses stats individuelles restent actives — seule sa contribution aux totaux est suspendue.

Les champs suivants sont **reportés en v1.1** :
- **Photo** — pour personnaliser la carte objet
- **Notes** — ex. *Acheté reconditionné, Apple Store Paris*
- **Facture** — photo ou PDF de la facture ou du ticket de caisse, stocké localement et attaché à l'objet

---

### 2. Dashboard objet — Stats en temps réel

Une fois l'objet ajouté, Renta calcule automatiquement et met à jour en continu :

| Stat | Description |
|------|-------------|
| **Coût/jour** | Prix d'achat ÷ nombre de jours depuis l'achat |
| **Coût/mois** | Coût/jour × 30,44 |
| **Coût/an** | Coût/jour × 365 |
| **Total amorti** | Montant "consommé" depuis l'achat |
| **Durée de possession** | En jours, mois et années |
| **Tendance** | Graphique de l'évolution du coût/jour dans le temps |

Exemple pour le Mac :
- 4 000 € ÷ 1 461 jours (4 ans) = **2,74 €/jour**
- Soit **83,4 €/mois** ou **1 000 €/an**

---

### 3. Date de vente (optionnelle)

L'utilisateur peut marquer un objet comme **vendu** en renseignant :

- **Date de vente**
- **Prix de vente**

Cela déverrouille les **stats finales** :

| Stat | Description |
|------|-------------|
| **Coût net total** | Prix d'achat − Prix de vente |
| **Coût net/jour** | Coût net ÷ jours de possession |
| **Coût net/mois** | Coût net ÷ mois de possession |
| **Durée totale de possession** | De la date d'achat à la date de vente |
| **Taux de récupération** | (Prix de vente ÷ Prix d'achat) × 100 — ex. *30% récupérés* |

Exemple : Mac vendu 1 200 €
- Coût net = 4 000 − 1 200 = **2 800 €**
- Sur 4 ans = **1,92 €/jour** au lieu de 2,74 €
- Taux de récupération = **30%**

L'objet passe en statut **"Vendu"** dans la liste, avec ses stats gelées.

---

### 4. Score de valeur

Chaque objet reçoit un **score de valeur** dynamique basé sur sa progression vers sa durée cible d'amortissement, choisie par l'utilisateur à la création. Ce score est visuel (jauge circulaire 0–100) et évolue dans le temps :

- 🔴 **High** — Premier tiers de la durée cible non atteint
- 🟡 **Correct** — Entre le premier et le deuxième tiers
- 🟢 **Excellent** — Au-delà des deux tiers de la durée cible

### Durées cibles disponibles

L'utilisateur choisit parmi 6 options à la création de l'objet. Les seuils sont calculés en proportion de la durée cible (milieu de la fourchette) :

| Durée cible | 🔴 High | 🟡 Correct | 🟢 Excellent |
|-------------|---------|-----------|-------------|
| Less than 6 months | 0 → 2 months | 2 → 4 months | 4+ months |
| 6 months to 1 year | 0 → 3 months | 3 → 6 months | 6+ months |
| 1 to 3 years | 0 → 8 months | 8 months → 1 yr 4 mo | 1 yr 4 mo+ |
| 3 to 5 years | 0 → 1 yr 4 mo | 1 yr 4 mo → 2 yr 8 mo | 2 yr 8 mo+ |
| 5 to 7 years | 0 → 2 years | 2 → 4 years | 4+ years |
| 7 years or more | 0 → 2 yr 4 mo | 2 yr 4 mo → 4 yr 8 mo | 4 yr 8 mo+ |

La durée cible est propre à chaque objet — un laptop et une sono dans la même liste peuvent avoir des durées cibles différentes et seront chacun jugés sur leur propre référentiel. Le score est donc toujours juste quel que soit le prix de l'objet.

### Cas particulier — Objet ajouté récemment

Pour un objet dont la **date d'achat est il y a moins de 7 jours**, le coût/jour est mécaniquement très élevé et ne reflète pas encore l'amortissement réel. Dans ce cas :

- Le score de valeur n'est **pas affiché**
- Un message contextuel remplace la jauge : *"Les stats seront disponibles le [date d'achat + 7 jours]"*
- Un bouton **"Me prévenir"** permet d'activer une notification unique pour ce jour-là

À partir du 8ème jour suivant la date d'achat, le score s'affiche normalement et la notification est envoyée si l'utilisateur l'avait demandée.

---

### 5. Vue globale — Tableau de bord

Vue d'ensemble de tous les objets actifs non exclus des analyses.

**Stats globales**

| Stat | Description |
|------|-------------|
| **Valeur totale du parc** | Somme des prix d'achat de tous les objets actifs inclus |
| **Coût/jour global** | Somme des coûts/jour de tous les objets actifs inclus |
| **Coût/mois global** | Coût/jour global × 30,44 |
| **Coût/an global** | Coût/jour global × 365 |
| **Total déjà amorti** | Somme du montant "consommé" sur tous les objets |
| **Montant restant à amortir** | Valeur totale du parc − Total déjà amorti |

**Stats par catégorie**

Pour chaque catégorie contenant au moins un objet actif inclus :
- Coût/jour de la catégorie
- Nombre d'objets
- Répartition visuelle (barres horizontales) du poids de chaque catégorie dans le coût/jour total

**Référentiel salaire** *(si renseigné dans les réglages)*

L'utilisateur renseigne dans les réglages :
- Son **salaire mensuel net** (en €)
- Son **nombre d'heures travaillées par semaine**

Renta en déduit automatiquement :
- Le **taux horaire net** : salaire mensuel ÷ (heures/semaine × 52 ÷ 12)
- Le **salaire journalier net** : taux horaire × (heures/semaine ÷ 5)
- Le **coût en temps de travail** de chaque objet et du total du parc

Exemples d'affichage dans le dashboard :
- *"Tes objets te coûtent l'équivalent de 23 min de travail par jour"*
- *"Ton Mac t'a coûté 14 jours de travail depuis l'achat"*

Affiché sous le coût/jour global comme ligne de contexte, non intrusif.

**Autres éléments du tableau de bord**
- **Top 3 des objets les plus coûteux** actuellement
- **Top 3 des objets les mieux amortis**
- **Historique** — liste des objets vendus avec leurs stats finales

**Vue par catégorie**

En tapant sur une catégorie dans le dashboard, l'utilisateur accède à un écran dédié listant tous les objets de cette catégorie. Sur cet écran, des filtres par tags sont disponibles pour affiner l'affichage — ex. afficher uniquement les objets tagués *"Travail"* dans la catégorie Technologie. Les stats globales de la catégorie (coût/jour, total amorti, nombre d'objets) sont affichées en header de cet écran.

> Les objets avec le toggle "Exclure des analyses globales" activé n'entrent dans aucun de ces calculs.

---

### 6. Projections

Pour les objets actifs, Renta peut projeter :

- **Quand le coût/jour passera sous un seuil** — ex. *"Ton Mac passera sous 1 €/jour dans 3 ans et 2 mois"*
- **Coût total estimé sur X années** — ex. *"Si tu gardes ce vélo 5 ans, il t'aura coûté 0,27 €/jour"*
- **Simulation de revente** — ex. *"Si tu le revends 800 € dans 6 mois, ton coût net sera de 1,74 €/jour"*

---

### 7. Notifications (optionnelles)

- **Milestone d'amortissement** — *"Ton Mac vient de passer sous 2 €/jour 🎉"*
- **Anniversaire de possession** — *"Ça fait 2 ans que tu as ton vélo"*
- **Rappel de revente** — Si l'utilisateur a noté une intention de vendre à une date cible

---

## Statuts d'un objet

| Statut | Description |
|--------|-------------|
| **Actif** | En possession, stats en temps réel |
| **Vendu** | Date + prix de vente renseignés, stats finales avec taux de récupération |
| **Fin de vie / Cassé** | Objet hors d'usage, sans revente. Coût net = prix d'achat complet. Stats gelées à la date de déclaration |
| **Offert / Perdu** | Marqué sans prix de vente, coût net = prix d'achat complet |

---

## États vides (Empty States)

Chaque état vide est une invitation à agir, pas un écran mort. Chacun a un message et une action primaire.

| Contexte | Message | Action |
|----------|---------|--------|
| **Aucun objet ajouté** (premier lancement post-onboarding) | *"Aucun objet pour l'instant. Ajoute ce que tu possèdes pour voir ce que ça te coûte vraiment."* | Bouton "Ajouter un objet" |
| **Dashboard global — tous les objets exclus des analyses** | *"Tous tes objets sont exclus des analyses. Active au moins un objet pour voir tes stats globales."* | Lien vers la liste des objets |
| **Catégorie vide** (custom créée mais aucun objet dedans) | *"Aucun objet dans cette catégorie."* | Bouton "Ajouter un objet" pré-rempli avec la catégorie |
| **Historique vide** (aucun objet vendu) | *"Aucun objet vendu pour l'instant. Quand tu vendras un objet, ses stats finales apparaîtront ici."* | Aucune action — message informatif |
| **Résultats de recherche vides** | *"Aucun objet ne correspond à cette recherche."* | Aucune action |



## Tags

Les tags sont optionnels, multiples et librement créés par l'utilisateur à la volée lors de l'ajout ou de la modification d'un objet. Ils n'influencent pas le score de valeur. Leur seul rôle est de permettre le **filtrage** dans la liste des objets et le dashboard.

### Comportement

- Créés directement depuis le champ de recherche dans le step "Tags" du flow d'ajout
- Un objet peut avoir zéro, un ou plusieurs tags
- Les tags existants sont proposés en suggestions lors de la saisie
- Les tags sont gérables depuis les réglages (renommer, supprimer)

### Exemples de tags

*Travail*, *Reconditionné*, *Cadeau*, *Perso*, *Prêté*, *Vintage*, *High-end*

---

## Stockage & Synchronisation

### Offline first

Renta fonctionne **intégralement hors ligne**. Toutes les données sont stockées localement sur l'appareil (via **CoreData** ou **SwiftData**). Aucune connexion réseau n'est requise pour utiliser l'app, consulter les stats ou ajouter un objet.

### Synchronisation iCloud

Les données sont synchronisées automatiquement avec **iCloud (CloudKit)** dès qu'une connexion est disponible. Cela garantit :

- **Aucune perte de données** en cas de perte ou changement d'iPhone
- **Synchronisation multi-appareils** si l'utilisateur utilise Renta sur plusieurs devices Apple (iPhone, iPad)
- **Restauration automatique** après réinstallation de l'app

La synchronisation est transparente pour l'utilisateur — aucun compte à créer, aucune action manuelle. Elle repose sur le compte iCloud existant de l'utilisateur.

> ⚠️ Si l'utilisateur n'est pas connecté à iCloud, l'app fonctionne normalement en local avec une bannière d'information non bloquante l'invitant à activer iCloud pour protéger ses données.

### Devise

Renta détecte automatiquement la **devise locale de l'iPhone** (via les paramètres régionaux iOS) et l'applique à tous les affichages de montants. Tous les prix sont saisis et stockés dans cette devise — aucune conversion n'est effectuée par l'app. Si un objet a été acheté dans une autre devise, l'utilisateur effectue la conversion lui-même avant de saisir le prix.

### Suppression des données

Depuis les **réglages de l'app**, une option *"Supprimer toutes mes données"* permet de remettre l'app à zéro. L'action est irréversible et demande une confirmation explicite (double confirmation : alerte système + saisie du mot "Supprimer"). Elle efface toutes les données locales et supprime la synchronisation iCloud associée. Aucun compte n'existant, il n'y a pas d'autre démarche nécessaire.

---

## Apple Intelligence — Intégration Siri

Renta expose ses données à Siri via **App Intents**, permettant à l'utilisateur d'interroger ses objets à la voix sans ouvrir l'app.

### Requêtes supportées

| Exemple de requête | Réponse attendue |
|--------------------|-----------------|
| *"Hey Siri, combien me coûte mon Mac par jour ?"* | *"Ton MacBook Pro M1 Max te coûte 2,74 € par jour."* |
| *"Hey Siri, combien m'a coûté mon vélo ce mois-ci ?"* | *"Ton vélo t'a coûté 9,20 € ce mois-ci."* |
| *"Hey Siri, quel est mon objet le plus cher en ce moment ?"* | *"C'est ton Mac, à 2,74 €/jour."* |
| *"Hey Siri, combien me coûtent tous mes objets par jour ?"* | *"L'ensemble de tes objets te coûte 4,12 € par jour."* |

L'intégration est **100% locale** — Siri lit directement la base SwiftData de l'app, aucune donnée ne transite par un serveur. Elle fonctionne donc même hors ligne, dans la continuité du positionnement offline-first de Renta.

---

## Widgets & Live Activities *(v1.1)*

Deux widgets et une Live Activity disponibles après la sortie du MVP, dans la mise à jour v1.1.

### Widget petit (2×2) — "L'objet du jour"

Affiche l'objet actuellement le plus coûteux avec :
- Son nom
- Son coût/jour en grand
- Son score de valeur en couleur (🟢 / 🟡 / 🔴)

Simple, glançable, pensé pour donner une petite impulsion — utiliser davantage l'objet, ou envisager de le vendre.

### Widget moyen (2×4) — "Mon coût du jour"

Affiche la vision macro de toutes les possessions actives :
- **Coût/jour total** en stat principale
- Liste des 3 objets qui pèsent le plus, avec leur coût/jour respectif

Les deux widgets sont disponibles en version claire et sombre, et respectent les tailles de police dynamique (Dynamic Type).

### Live Activity — Milestone en approche

Lorsqu'un objet est proche de franchir un seuil de score (ex. passage de 🔴 à 🟡, ou de 🟡 à 🟢), une Live Activity s'affiche sur l'écran de verrouillage et dans la Dynamic Island. Elle montre :
- Le nom de l'objet
- Une barre de progression vers le prochain seuil
- Le coût/jour actuel et le seuil cible
- Le nombre de jours restants estimé avant le franchissement

La Live Activity se ferme automatiquement une fois le seuil atteint, déclenchant la notification de milestone correspondante.

---

## Architecture de données — Modèle objet

```
Item {
  id: string
  name: string
  emoji: string                // ex. "💻" — choisi par l'user
  purchase_price: number       // en €
  purchase_date: date
  duration_target: string      // ex. "1_to_3_years" — détermine les seuils du score
  tag_ids: string[]            // références vers Tag — optionnel, multiple
  photo_url?: string             // v1.1
  invoice_url?: string           // v1.1 — photo ou PDF de la facture
  notes?: string                 // v1.1
  status: "active" | "sold" | "end_of_life" | "gifted" | "lost"
  exclude_from_global: boolean // défaut: false

  // Si vendu
  sale_date?: date
  sale_price?: number

  // Calculé dynamiquement
  days_owned: number           // calculé à partir de purchase_date
  cost_per_day: number         // purchase_price / days_owned
  cost_per_month: number       // cost_per_day × 30.44
  cost_per_year: number        // cost_per_day × 365
  net_cost?: number            // purchase_price - sale_price
  net_cost_per_day?: number    // net_cost / days_owned
  recovery_rate?: number       // (sale_price / purchase_price) × 100
  value_score: "excellent" | "correct" | "high"
  score_value: number          // 0–100 — position dans la jauge circulaire
}

Tag {
  id: string
  name: string                 // ex. "Travail", "Reconditionné", "Cadeau"
}

DurationTarget {               // valeurs fixes, modifiables dans les réglages en v1.1
  id: string                   // ex. "lt_6_months", "1_to_3_years", "7_years_plus"
  label: string                // ex. "1 to 3 years"
  target_days: number          // milieu de la fourchette en jours — ex. 730 pour 1-3 ans
  threshold_correct: number    // target_days × 0.33
  threshold_excellent: number  // target_days × 0.66
}

UserSettings {
  monthly_net_salary?: number    // optionnel — salaire mensuel net en €
  weekly_hours?: number          // optionnel — heures travaillées par semaine

  // Calculé automatiquement
  hourly_rate?: number           // monthly_net_salary ÷ (weekly_hours × 52 ÷ 12)
  daily_salary?: number          // hourly_rate × (weekly_hours ÷ 5)
}
```

---

## Monétisation

Modèle **freemium avec achat unique** — pas d'abonnement. Renta est 100% offline et ne génère aucun coût serveur, ce qui rend un abonnement injustifiable pour l'utilisateur. L'achat unique est aussi cohérent avec le positionnement de l'app : pas de compte, pas de données en ligne, tes objets t'appartiennent.

### Gratuit — pour toujours

- Jusqu'à **10 objets actifs**
- Tags illimités
- Stats de base (coût/jour, /mois, /an, score de valeur)
- Toutes les durées cibles disponibles
- Synchronisation iCloud

### Renta Pro — achat unique à 4,99 €

- Objets actifs **illimités**
- Projections & simulation de revente
- Widgets *(disponibles en v1.1)*
- Notifications & milestones

> La limite à 10 objets est suffisamment généreuse pour tester l'app sérieusement, et suffisamment contraignante pour que quelqu'un qui y prend goût ressente le besoin de passer Pro. 4,99 € est le prix psychologique naturel pour une app utilitaire iOS de qualité — ni dévalorisant, ni bloquant.

---

## Nom & Identité

**Nom : Renta**

Court, mémorisable, évoque directement la rentabilité et la durée. Fonctionne en français et en anglais.

Alternatives envisagées : *Amort*, *Valu*, *Durable*, *Costly*

**Tagline candidate :** *"Ce que tu possèdes a un prix. Découvre ce qu'il te coûte vraiment."*

---

## Ce que Renta n'est pas

- Pas un gestionnaire de budget ou de dépenses globales (≠ Bankin, Lydia)
- Pas un inventaire d'assurance
- Pas un tracker patrimonial

Renta se concentre sur **une seule mécanique** : le coût d'usage dans le temps, rendu visible et satisfaisant.

---

## Roadmap envisagée

### MVP (v1.0)
- Onboarding (4 étapes : concept, salaire optionnel, notifications, premier objet)
- Ajout / édition / suppression d'objets
- Sélecteur de durée cible à la création (6 options avec exemples contextuels)
- Stats en temps réel (coût/jour, /mois, /an)
- Score de valeur basé sur la durée cible (jauge circulaire 0–100)
- Gestion du score J+1 à J+7 (message + notification "Me prévenir")
- Statut vendu + stats finales (coût net, taux de récupération)
- Tags libres par objet (création à la volée, filtrage)
- Vue globale enrichie (stats globales + filtres par tag)
- Toggle "Exclure des analyses globales" par objet
- Référentiel salaire (optionnel, local)
- Projections (seuils, simulation revente)
- Notifications & milestones
- États vides
- Devise automatique (locale iPhone)
- Suppression des données dans les réglages
- Siri via App Intents
- Stockage offline + synchronisation iCloud (CloudKit)
- Monétisation freemium (achat unique 4,99 €)

### v1.1
- Widget petit 2×2 — "L'objet du jour"
- Widget moyen 2×4 — "Mon coût du jour"
- Live Activity — Milestone en approche (écran de verrouillage + Dynamic Island)
- Page de réglages pour personnaliser les seuils des durées cibles (modifier les tiers Correct / Excellent pour chaque option, avec bouton reset)
- Photo par objet (pour personnaliser la carte)
- Notes par objet
- Facture attachée par objet (photo ou PDF)
- Scan de facture ou ticket de caisse pour pré-remplir la création d'un objet (Vision framework)
- Export des données (CSV, PDF)
- Support multi-devises

---

*Document rédigé le 10 juin 2026 — sujet à évolution*
