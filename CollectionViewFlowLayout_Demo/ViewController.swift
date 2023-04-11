//
//  ViewController.swift
//  CollectionViewFlowLayout_Demo
//
//  Created by JINSEOK on 2023/04/11.
//

import UIKit
import SnapKit

class ViewController: UIViewController {
 

    override func viewDidLoad() {
        super.viewDidLoad()
        setupCollectioView()
    }

    func setupCollectioView() {
        // 만들어 준 FlowLayout을 생성해줍시다.
        let flowLayout = createFlowLayout()
        // FlowLayout을 갖고 collectionView의 객체를 생성
        let collectionView = UICollectionView(frame: .zero, collectionViewLayout: flowLayout)
        
        view.addSubview(collectionView)
        collectionView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        // dataSource 및 delegate 채택
        collectionView.dataSource = self
        collectionView.delegate = self
        
        collectionView.backgroundColor = .gray
        
        // 만들어준 UICollectionViewCell 클래스로 식별자를 등록해줍니다.
        collectionView.register(CustomCell.self, forCellWithReuseIdentifier: "cell")
        collectionView.register(HeaderReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionHeader, withReuseIdentifier: "header")
        collectionView.register(FooterReusableView.self, forSupplementaryViewOfKind: UICollectionView.elementKindSectionFooter, withReuseIdentifier: "footer")
    }
    
    func createFlowLayout() -> UICollectionViewFlowLayout {
        
        let layout = UICollectionViewFlowLayout()
        // 스크롤을 방향 (기본값 vertical)
        layout.scrollDirection = .vertical
        // 그리드 줄 간격 (기본값 10)
        layout.minimumLineSpacing = 20
        // 그리드 행 간격 (기본값 10)
        layout.minimumInteritemSpacing = 20
        // 각 cell의 크기 설정. 기본 크기는 (50, 50)
        layout.itemSize = CGSize(width: 100, height: 100)
        // 동적으로 cell의 크기를 계산할 때 성능을 높여 준다고 합니다.
        layout.estimatedItemSize = CGSize(width: 100, height: 100)
        // section에 대한 여백을 설정합니다.
        layout.sectionInset = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        // header, footer 크기 지정
        // 스크롤 방향에 따라서 크기의 영향을 받는다. (vertical은 height값만 갖고 계산, horizontal 일 경우 width만 영향을 받는다)
        layout.headerReferenceSize = CGSize(width: 50, height: 100)
        layout.footerReferenceSize = CGSize(width: 50, height: 100)
        // header, footer를 고정, 기본값 false (스크롤해도 고정 됨)
        layout.sectionHeadersPinToVisibleBounds = true
        layout.sectionFootersPinToVisibleBounds = true
        
        return layout
    }

}

extension ViewController: UICollectionViewDataSource, UICollectionViewDelegate {
    
    // section의 갯수
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    // cell의 갯수
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 15
    }
    
    // cell에 표현될 뷰를 설정
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        // 위에서 등록해 둔 withReuseIdentifier를 갖고 cell을 만듭니다.
        // 커스텀 셀을 만들어 사용 시 다운 캐스팅으로 설정한 타입으로 변환 시켜줘서 사용합니다.
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as? CustomCell else {
            fatalError("Failed to load cell!")
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {

        switch kind {
            
        case UICollectionView.elementKindSectionHeader:
            // 헤더 세팅
            guard let header = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "header", for: indexPath) as? HeaderReusableView else {
                fatalError("Failed to load Header!")
            }
            return header
            
        case UICollectionView.elementKindSectionFooter:
            // 푸터 세팅
            guard let footer = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: "footer", for: indexPath) as? FooterReusableView else {
                fatalError("Failed to load Footer!")
            }
            return footer
            
        default: break
        }
        
        return UICollectionReusableView()
    }
}

// UICollectionViewDelegateFlowLayout 델리게이트 값이 적용된다. 위의 초기 설정들은 무시
extension ViewController: UICollectionViewDelegateFlowLayout {
    // 파라미터에 들어있는 타입이름이 위의 속성과 비슷합니다.
    
    // 셀의 크기를 지정
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        // 여백과 뷰 크기를 통해 값을 계싼해 설정하면 원하는 배치로대로 레이아웃을 쉽게 잡을 수 있다.
        return CGSize(width: (view.frame.width-70)/3, height: (collectionView.frame.height-110)/5)
    }
    
    // 그리드 줄 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // 그리드 행 간격
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
        return 20
    }
    
    // section 여백
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 10, left: 10, bottom: 10, right: 10)
    }
    
    // header, footer 크기 변경도 있어요
}







import SwiftUI

#if DEBUG
extension UIViewController {
    private struct Preview: UIViewControllerRepresentable {
        let viewController: UIViewController
        
        func makeUIViewController(context: Context) -> UIViewController {
            return viewController
        }
        
        func updateUIViewController(_ uiViewController: UIViewController, context: Context) {
        }
    }
    
    func toPreview() -> some View {
        Preview(viewController: self)
    }
}
#endif


// MARK: - PreView 읽기
import SwiftUI

#if DEBUG
struct PreView: PreviewProvider {
    static var previews: some View {
        // 사용할 뷰 컨트롤러를 넣어주세요
        ViewController()
            .toPreview()
    }
}
#endif
